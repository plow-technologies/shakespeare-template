

{- |
Module      : Text.Shakespeare.Template
Description :  Make string templates using shakespeare engine
Copyright   :  (c) Plow Technologies
License     :  MIT License
Maintainer  :  Scott Murphy
Stability   :  unstable
Portability :   non-portable (System.Posix)


This file is intended to provide functions that make it simple to see how to use shakespeare to do template creation outside of yesod.

There are lots of advantages to this, most notably a built in programmatic interpolation facility that is highly expressive.

* all the hamlet stuff results in types that are of the form (t -> Html)  the t is used to render HTML inside your document.

Currently this library is not designed to work with URL rendering so do not use '@' interpolation.

* #{} , $foreach, $maybe, and ^{}
are available

-- Example
>>> hamletToText [hamlet|<div>test|]
"<div>test</div>\n\n"

One possible drawback to this template system,
Templates are static -- this means you have to be creative with your templating to get dynamic effects.


-}


{-# LANGUAGE OverloadedStrings #-}

module Text.Shakespeare.Template (hamletToText
                                 ,hamletToString
                                 ,grs
                                 ,hamletToFile
                                 ) where


import           Data.Text.Lazy
import           Data.Text.Lazy.IO
import           Prelude                         hiding (writeFile)
import           Text.Blaze.Html.Renderer.Pretty
import           Text.Hamlet


grs :: HamletSettings
grs = defaultHamletSettings { hamletNewlines = NewlinesText}



hamletToText :: HtmlUrl url  -> Text
hamletToText hstr = pack.renderHtml $ hstr dummyFcn
 where
  dummyFcn _ _ = ""

hamletToString :: HtmlUrl url -> String
hamletToString hstr = renderHtml $ hstr dummyFcn
 where
  dummyFcn _ _ = ""

hamletToFile :: FilePath -> HtmlUrl url -> IO ()
hamletToFile fp hstr = writeFile fp (pack.renderHtml $ hstr dummyFcn)
 where
  dummyFcn _ _ = ""

