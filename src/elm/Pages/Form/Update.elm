module Pages.Form.Update exposing (update, Msg(..))

import Form exposing (Form)
import Pages.Form.Model as Form exposing (..)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = FormMsg Form.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        FormMsg formMsg ->
            { model | form = Form.update formMsg model.form } ! []
