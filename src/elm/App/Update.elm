module App.Update exposing (init, update, Msg(..))

import App.Model exposing (..)
import Config.Model as Config
import Pages.Form.Update exposing (Msg)
import RemoteData exposing (RemoteData(..), WebData)


type Msg
    = PageForm Pages.Form.Update.Msg
    | SetActivePage Page
    | SetConfig Config.Model
    | SetConfigError


init : ( Model, Cmd Msg )
init =
    let
        pageFormFx =
            snd <| Pages.Form.Update.init
    in
        emptyModel ! [ Cmd.map PageForm pageFormFx ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        backendUrl =
            case model.config of
                Success config ->
                    config.backendUrl

                _ ->
                    ""
    in
        case msg of
            PageForm msg ->
                let
                    ( val, cmds ) =
                        Pages.Form.Update.update msg model.pageForm

                    model' =
                        { model | pageForm = val }
                in
                    ( model', Cmd.map PageForm cmds )

            SetActivePage page ->
                { model | activePage = page } ! []

            SetConfig config ->
                { model | config = Success config } ! []

            SetConfigError ->
                { model | config = Failure "No config found" } ! []
