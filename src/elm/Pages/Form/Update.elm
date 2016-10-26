module Pages.Form.Update exposing (acceptablePeople, init, update, Msg(..))

import Autocomplete
import Form exposing (Form)
import Pages.Form.Model as Form exposing (..)
import String


type Msg
    = FormMsg Form.Msg
    | NoOp
    | SetAutoState Autocomplete.Msg
    | SetQuery String
    | SelectPerson String


init : ( Model, Cmd Msg )
init =
    emptyModel ! []



-- Let's filter the data however we want


acceptablePeople : Model -> List Person
acceptablePeople { query, people } =
    let
        lowerQuery =
            String.toLower query
    in
        List.filter (String.contains lowerQuery << String.toLower << .name) people



-- Set up what will happen with your menu updates


updateConfig : Autocomplete.UpdateConfig Msg Person
updateConfig =
    Autocomplete.updateConfig
        { toId = .name
        , onKeyDown =
            \code maybeId ->
                if code == 13 then
                    Maybe.map SelectPerson maybeId
                else
                    Nothing
        , onTooLow = Nothing
        , onTooHigh = Nothing
        , onMouseEnter = \_ -> Nothing
        , onMouseLeave = \_ -> Nothing
        , onMouseClick = \id -> Just <| SelectPerson id
        , separateSelections = False
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        FormMsg formMsg ->
            { model | form = Form.update formMsg model.form } ! []

        NoOp ->
            model ! []

        SetAutoState autoMsg ->
            let
                ( newState, maybeMsg ) =
                    Autocomplete.update updateConfig autoMsg 10 model.autoState (acceptablePeople model)

                newModel =
                    { model | autoState = newState }
            in
                case maybeMsg of
                    Nothing ->
                        newModel ! []

                    Just updateMsg ->
                        update updateMsg newModel

        SetQuery newQuery ->
            { model | query = newQuery } ! []

        SelectPerson id ->
            { model
                | query =
                    List.filter (\person -> person.name == id) model.people
                        |> List.head
                        |> Maybe.withDefault (Person "" 0 "" "")
                        |> .name
                , autoState = Autocomplete.empty
            }
                ! []
