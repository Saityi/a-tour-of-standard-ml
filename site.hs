{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
import           Data.Functor
import           Data.Monoid (mappend)
import           Data.Traversable
import           Hakyll
import           Hakyll.Web.Sass (sassCompiler)
import           Hakyll.Web.Redirect
import           Data.List
import           System.FilePath

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
    match "templates/*" $ do
        route idRoute
        compile templateBodyCompiler

    match "js/*" $ do
        route idRoute
        compile copyFileCompiler
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
          code  <- loadBody expath
          pages <- loadAll ("tour/*" .&&. hasVersion "precomp")
          let codeCtx = if (null code) 
                        then tourContext 
                        else (tourContext <> constField "code" code)
              ctx = codeCtx
                <> listField "pages" tourContext (return pages)
                <> paginateContext paginator page
                <> constField "examplef" (show expath)
              
          pandocCompiler
            >>= loadAndApplyTemplate "templates/tour.html" ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls
    
    create ["index.html"] $ do
      route idRoute
      compile $ makeItem $ Redirect "tour/00-00-welcome.html"


tourContext :: Context String
tourContext = defaultContext

codePath ident = fromFilePath ("examples/" <> (takeBaseName $ toFilePath ident) <> ".sml")