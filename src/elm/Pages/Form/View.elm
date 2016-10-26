module Pages.Form.View exposing (view)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Form exposing (Form)
import Form.Input as Input
import Pages.Form.Model exposing (..)
import Pages.Form.Update exposing (..)


view : Model -> Html Pages.Form.Update.Msg
view model =
    div []
        [ (formView model model.form)
        ]


formView : Model -> Form () DynamicForm -> Html Msg
formView model form =
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
            [ onSubmit (FormMsg Form.Submit)
            , class "ui form"
            ]
            [ div [ class "field" ]
                [ label [] [ text "Bar" ]
                , Html.map FormMsg (Input.textInput bar [])
                , errorFor bar
                ]
            , input
                [ onInput SetSimpleField
                , value model.simpleField
                ]
                []
            , div [ class "field" ]
                [ div [ class "ui checkbox" ]
                    [ Html.map FormMsg (Input.checkboxInput baz [])
                    , label [] [ text "Baz" ]
                    , errorFor baz
                    ]
                ]
            , button
                [ onClick (FormMsg Form.Submit)
                , class "ui primary button"
                ]
                [ text "Submit" ]
            ]
