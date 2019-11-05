{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Hakyll.Web.Redirect
import           Data.List
import           System.FilePath

main :: IO ()
main = hakyll $ do 
    match "templates/*" $ do
        route idRoute
        compile templateBodyCompiler

    match "js/*" $ do
        route idRoute
        compile copyFileCompiler
    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    match "examples/*" $ do
        route   idRoute
        compile getResourceBody
    
    -- Preload the tour files to make the metadata available in the sidenav
    match "tour/*" $ version "precomp" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
          >>= loadAndApplyTemplate "templates/tour.html" tourContext
          >>= relativizeUrls
    
    match "tour/*" $ do
        route $ setExtension "html"
        compile $ do
          ident <- getUnderlying
          code  <- loadBody (codePath ident)
          pages <- loadAll ("tour/*" .&&. hasVersion "precomp")
          let ctx = tourContext <> listField "pages" tourContext (return pages)
              ctx' = if (null code) then ctx else ctx <> constField "code" code
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