

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

* #{} , $foreach, $maybe 
are available

One possible drawback to this template system,
Templates are static -- this means you have to be creative with your templating to get dynamic effects.



-}


{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}

module Text.Shakespeare.Template (hamletToText
                                 ,hamletToString
                                 ,grs
                                 ,hamletToFile
                                 ) where

import Text.Shakespeare.Template.Internal
import Prelude hiding (writeFile)
import Text.Hamlet
import Text.Blaze.Html.Renderer.Pretty
import Data.Text.Lazy.IO
import Data.Text.Lazy
import Data.String (IsString)


grs = defaultHamletSettings { hamletNewlines = NewlinesText}

hamletToText :: (() -> Html) -> Text
hamletToText hstr = pack.renderHtml $ hstr ()

hamletToString :: (() -> Html) -> String
hamletToString hstr = renderHtml $ hstr ()


hamletToFile :: FilePath -> (() -> Html) -> IO () 
hamletToFile fp hstr = writeFile fp (pack.renderHtml $ hstr ())
-- hamletfileToString :: FilePath -> String
-- hamletfileToString fname = renderHtml $ (hamletFile fname ) ()


