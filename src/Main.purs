module Main where

import Toppokki as T
import Prelude (bind, discard, (>))
import Effect (Effect)
import Data.Unit (Unit)
import Effect.Aff (launchAff_)
import Test.Unit.Assert as Assert
import Data.String as String

main :: Effect Unit
main =
  launchAff_ do
    browser <- T.launch {}
    page <- T.newPage browser
    T.goto (T.URL "https://bundestag.de/abgeordnete") page
    content <- T.content page
    Assert.assert "content is non-empty string" (String.length content > 0)
    _ <- T.screenshot { path: "./test/bundestag.png" } page
    _ <- T.pdf { path: "./test/bundestag.pdf" } page
    T.close browser
