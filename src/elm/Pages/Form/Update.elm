module Pages.Form.Update exposing (init, update, Msg(..))

import Form exposing (Form)
import Pages.Form.Model as Form exposing (..)


type Msg
    = FormMsg Form.Msg


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        FormMsg formMsg ->
            { model | form = Form.update formMsg model.form } ! []
