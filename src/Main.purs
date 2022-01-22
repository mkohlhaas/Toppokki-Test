module Main where

import Prelude (bind, discard, pure, unit, (<>), ($), (>>>))
import Data.Foldable (for_)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import MdBs (Mdb, emailText, mdbs)
import Toppokki as T
import Control.Promise (Promise, toAffE)

foreign import sleepImpl :: Int -> Effect (Promise Unit)

sleep :: Int -> Aff Unit
sleep = sleepImpl >>> toAffE

sendEmail :: Mdb -> Aff Unit
sendEmail mdb = do
  browser <- T.launch { headless: true }
  page <- T.newPage browser
  T.goto (T.URL $ "https://www.bundestag.de/services/formular/contactform?mdbId=" <> mdb.id) page
  _ <- T.type_ (T.Selector "#formelement-444044") "Covid-19 Impfpflicht" {} page
  _ <- T.type_ (T.Selector "#formelement-444048") (mdb.salutation <> emailText) {} page
  _ <- T.type_ (T.Selector "#formelement-444108") "michaela.kohlhaas@mein.gmx" {} page
  _ <- T.click (T.Selector "label[for='formelement-558174']") page
  _ <- T.click (T.Selector "label[for='formelement-444122']") page
  _ <- T.screenshot { path: "./test/" <> mdb.id <> ".png", fullPage: true } page
  _ <- T.click (T.Selector "button.bt-button-message") page
  _ <- T.waitForNavigation { waitUntil: T.networkIdle2 } page
  sleep 600000
  -- _ <- T.screenshot { path: "./test/" <> mdb.id <> "_confirmation" <> ".png", fullPage: true } page
  T.close browser
  pure unit

main :: Effect Unit
main =
  launchAff_ do
    for_ mdbs \mdb -> sendEmail mdb
