module Pages.Form.View exposing (view)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onSubmit)
import Form exposing (Form)
import Form.Input as Input
import Pages.Form.Model exposing (..)
import Pages.Form.Update exposing (..)


view : Model -> Html Msg
view model =
    Html.map FormMsg (formView model.form)


formView : Form () DynamicForm -> Html Form.Msg
formView form =
    let
        -- error presenter
        errorFor field =
            case field.liveError of
                Just error ->
                    -- replace toString with your own translations
                    div [ class "error" ] [ text (toString error) ]

                Nothing ->
                    text ""

        -- fields states
        bar =
            Form.getFieldAsString "bar" form

        baz =
            Form.getFieldAsBool "baz" form
    in
        Html.form
            [ onSubmit Form.Submit
            , class "ui form"
            ]
            [ div [ class "field" ]
                [ label [] [ text "Bar" ]
                , Input.textInput bar []
                , errorFor bar
                ]
            , div [ class "field" ]
                [ div [ class "ui checkbox" ]
                    [ Input.checkboxInput baz []
                    , label [] [ text "Baz" ]
                    , errorFor baz
                    ]
                ]
            , button
                [ onClick AddAnother
                , class "ui primary button"
                ]
                [ text "Submit" ]
            , button
                [ onClick Form.Submit
                , class "ui primary button"
                ]
                [ text "Submit" ]
            ]
