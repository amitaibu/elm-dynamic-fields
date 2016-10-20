module App.Model exposing (emptyModel, Model, Page(..))

import Config.Model exposing (Model)
import RemoteData exposing (RemoteData(..), WebData)
import Pages.Form.Model exposing (emptyModel, Model)


type Page
    = Form


type alias Model =
    { activePage : Page
    , config : RemoteData String Config.Model.Model
    , pageForm : Pages.Form.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Form
    , config = NotAsked
    , pageForm = Pages.Form.Model.emptyModel
    }
