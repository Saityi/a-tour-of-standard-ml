{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Data.Traversable
import           Hakyll
import           Hakyll.Web.Sass (sassCompiler)
import           Hakyll.Web.Redirect
import           Data.List
import           System.FilePath


sortIds :: MonadMetadata m => [Identifier] -> m [Identifier]
sortIds ids = fmap (\(_, _, i) -> i) <$> sort <$> indexed
  where 
    indexed = for ids $ \i -> do
      chIdx <- getMetadataField' i "index"
      chSec <- getMetadataField' i "section"
      return $ (read chIdx :: Int, read chSec :: Int, i)

tourPaginator :: MonadMetadata m => m Paginate
tourPaginator = do
  pages <- getAllMetadata "tour/*"
  ids   <- sortIds $ fst <$> pages
  let pageId n = ids !! (n - 1)
      grouper ps = pure $ map (\p -> [p]) ps
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

    p <- tourPaginator

    -- Preload the tour files to make the metadata available in the sidenav
    match "tour/*" $ version "precomp" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
          >>= loadAndApplyTemplate "templates/tour.html" tourContext
          >>= relativizeUrls
  
    paginateRules p $ \page pattern -> do
        route $ setExtension "html"
        compile $ do
          ident <- getUnderlying
          let expath = codePath ident
          code  <- loadBody expath
          pages <- loadAll ("tour/*" .&&. hasVersion "precomp")
          let ctx = tourContext <> listField "pages" tourContext (return pages)
              codectx = if (null code) then ctx else ctx <> constField "code" code
              ctx' = codectx <> paginateContext p page <> constField "examplef" (show expath)
          pandocCompiler
            >>= loadAndApplyTemplate "templates/tour.html" ctx'
            >>= loadAndApplyTemplate "templates/default.html" ctx'
            >>= relativizeUrls
    
    create ["index.html"] $ do
      route idRoute
      compile $ makeItem $ Redirect "tour/00-00-welcome.html"


tourContext :: Context String
tourContext = defaultContext

codePath ident = fromFilePath ("examples/" <> (takeBaseName $ toFilePath ident) <> ".sml")