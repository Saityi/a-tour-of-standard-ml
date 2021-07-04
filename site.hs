{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
import           Control.Monad.Except
import           Data.Functor
import           Data.Monoid (mappend)
import           Data.Traversable
import           Data.Text
import           Text.Pandoc
import           Hakyll
import           Hakyll.Web.Sass (sassCompiler)
import           Hakyll.Web.Redirect
import           Hakyll.Web.Pandoc
import           Data.List
import           System.FilePath

highlight :: Text -> Compiler Text
highlight t =
  let md = "``` sml\n" <> t <> "\n```"
  in unsafeCompiler $ runIOorExplode $
     readMarkdown defaultHakyllReaderOptions md >>=
     writeHtml5String defaultHakyllWriterOptions

sortIds :: MonadMetadata m => [Identifier] -> m [Identifier]
sortIds ids = fmap third . sort <$> indexedIdents
  where
    indexedIdents = for ids $ \ident -> do
      chIdx <- getMetadataField' ident "index" <&> read @Int
      chSec <- getMetadataField' ident "section" <&> read @Int
      pure (chIdx, chSec, ident)
    third (_, _, z) = z

tourPaginator :: MonadMetadata m => m Paginate
tourPaginator = do
  ms  <- getAllMetadata "tour/*"
  ids <- sortIds $ (\(ident, meta) -> ident) <$> ms
  let pageId n = ids !! (n - 1) -- start indices at 0
      grouper = pure . fmap (\p -> [p])
  buildPaginateWith grouper "tour/*" pageId

main :: IO ()
main = hakyll $ do
    match "etc/*" $ do
        route idRoute
        compile copyFileCompiler

    match "templates/*" $ do
        route idRoute
        compile templateBodyCompiler

    match "css/*.scss" $ do
        route $ setExtension "css"
        let compressCssItem = fmap compressCss
        compile (compressCssItem <$> sassCompiler)

    match "examples/*" $ do
        route   idRoute
        compile getResourceBody
    -- Preload the tour files to make the metadata available in the sidenav
    match "tour/*" $ version "precomp" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
          >>= loadAndApplyTemplate "templates/tour.html" tourContext
          >>= relativizeUrls

    paginator <- tourPaginator
    paginateRules paginator $ \page pattern -> do
        route $ setExtension "html"
        compile $ do
          ident <- getUnderlying
          let expath = codePath ident
          code  <- (Data.Text.pack <$> loadBody expath) `catchError` (const . pure $ "")
          pages <- loadAll ("tour/*" .&&. hasVersion "precomp")
          let codeCtx = if (Data.Text.null code)
                        then tourContext
                        else ( tourContext
                            <> constField "code" (Data.Text.unpack code)
                            <> constField "examplef" (show expath))
              ctx = codeCtx
                <> listField "pages" tourContext (return pages)
                <> paginateContext paginator page

          pandocCompiler
            >>= loadAndApplyTemplate "templates/tour.html" ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

    create ["index.html"] $ do
      route idRoute
      compile $ makeItem $ Redirect "tour/welcome"


tourContext :: Context String
tourContext = defaultContext

codePath :: Identifier -> Identifier
codePath ident = fromFilePath ("examples/" <> Data.List.drop 6 (takeBaseName $ toFilePath ident) <> ".sml")
