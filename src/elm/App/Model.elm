module App.Model exposing (emptyModel, Model, Page(..))

import Config.Model exposing (Model)
import RemoteData exposing (RemoteData(..), WebData)
import User.Model exposing (..)
import Pages.Counter.Model exposing (emptyModel, Model)
import Pages.Form.Model exposing (emptyModel, Model)
import Pages.Login.Model exposing (emptyModel, Model)


type Page
    = AccessDenied
    | Counter
    | Form
    | Login
    | MyAccount
    | PageNotFound


type alias Model =
    { activePage : Page
    , config : RemoteData String Config.Model.Model
    , pageCounter : Pages.Counter.Model.Model
    , pageForm : Pages.Form.Model.Model
    , pageLogin : Pages.Login.Model.Model
    , user : WebData User
    }


emptyModel : Model
emptyModel =
    { activePage = Form
    , config = NotAsked
    , pageCounter = Pages.Counter.Model.emptyModel
    , pageForm = Pages.Form.Model.emptyModel
    , pageLogin = Pages.Login.Model.emptyModel
    , user = NotAsked
    }
