module Main where

import Prelude (bind, discard, (>), (<>), ($))
import Data.String as String
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Aff (launchAff_)
import MdBs
import Test.Unit.Assert as Assert
import Toppokki as T

abdi :: Mdb
abdi = { id: "861028", salutation: "Sehr geehrte Frau Sanae Abdi," }

main :: Effect Unit
main =
  launchAff_ do
    browser <- T.launch { headless: false }
    page <- T.newPage browser
    T.goto (T.URL $ "https://www.bundestag.de/services/formular/contactform?mdbId=" <> abdi.id) page
    _ <- T.type_ (T.Selector "#formelement-444044") "Impfpflicht" {} page
    _ <- T.type_ (T.Selector "#formelement-444048") (abdi.salutation <> "\n\ngemäß dem Nürnberger Kodex ...") {} page
    _ <- T.type_ (T.Selector "#formelement-444108") "michaela.kohlhaas@yandex.com" {} page
    _ <- T.click (T.Selector "label[for='formelement-558174']") page
    _ <- T.click (T.Selector "label[for='formelement-444122']") page
    -- _ <- T.click (T.Selector "button[type='submit']") page
    content <- T.content page
    Assert.assert "content is non-empty string" (String.length content > 0)
    _ <- T.screenshot { path: "./test/" <> abdi.id <> ".png", fullPage: true } page
    -- _ <- T.pdf { path: "./test/bundestag.pdf" } page
    T.close browser
