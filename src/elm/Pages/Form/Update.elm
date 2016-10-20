module Pages.Form.Update exposing (init, update, Msg(..))

import Date exposing (..)
import DatePicker exposing (defaultSettings)
import Form exposing (Form)
import Pages.Form.Model as Form exposing (..)


type Msg
    = FormMsg Form.Msg
    | ToDatePicker DatePicker.Msg


init : ( Model, Cmd Msg )
init =
    let
        isDisabled date =
            dayOfWeek date `List.member` [ Sat, Sun ]

        ( datePicker, datePickerFx ) =
            DatePicker.init { defaultSettings | isDisabled = isDisabled }
    in
        emptyModel ! [ Cmd.map ToDatePicker datePickerFx ]


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        FormMsg formMsg ->
            { model | form = Form.update formMsg model.form } ! []

        ToDatePicker msg ->
            let
                ( datePicker, datePickerFx, mDate ) =
                    DatePicker.update msg datePicker

                date =
                    case mDate of
                        Nothing ->
                            -- @todo: Get the date from the form
                            Date.fromTime 0

                        Just date ->
                            date
            in
                { model | datePicker = datePicker } ! [ Cmd.map ToDatePicker datePickerFx ]
