{-# LANGUAGE OverloadedStrings,TemplateHaskell, QuasiQuotes #-}
module Text.Shakespeare.TemplateSpec (main, spec) where
import Text.Shakespeare.Template
import Test.Hspec
import Text.Hamlet
import Text.Blaze.Html.Renderer.Pretty

-- toStrict.renderHtml $ [shamlet|

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "hamToText" $ do
    it "should translate an hamlet-template to text" $ do
      (hamletToText $ testHamlet 3) `shouldBe` testResult


cowboy :: Maybe Int
cowboy = Just 3
testHamlet :: Int -> t -> Html
testHamlet i  = [hamlet| a #{i} 

|]

testHamletFile name myName = $(hamletFileWithSettings hamletRules grs "test_template.hamlet")
testResult = "a \n3\n \n"


testHamlet2 :: [Int] -> t -> Html
testHamlet2 names  = [hamlet| 

<h1> Here is an example string template
<h2> Thanks to the pretty printer in Blaze
<h3> We can do super fun stuff like 
<h4> This
  Hello:::: 
<table .table>  
  $forall name <- names
    <tr>
      <td>  #{name} 

|]
