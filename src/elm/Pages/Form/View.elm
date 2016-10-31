module Pages.Form.View exposing (view)

import Autocomplete
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Form exposing (Form)
import Form.Input as Input
import Pages.Form.Model exposing (..)
import Pages.Form.Update exposing (..)


view : Model -> Html Pages.Form.Update.Msg
view model =
    let
        options =
            { preventDefault = True, stopPropagation = False }

        dec =
            (Json.customDecoder keyCode
                (\code ->
                    if code == 38 || code == 40 then
                        Ok NoOp
                    else
                        Err "not handling that key"
                )
            )
    in
        div []
            [ input
                [ onInput SetQuery
                , onWithOptions "keydown" options dec
                , class "autocomplete-input"
                , value model.query
                ]
                []
            , viewMenu model
            , Html.map FormMsg (formView model.form)
            ]


viewMenu : Model -> Html Msg
viewMenu model =
    let
        showMenu =
            not << List.isEmpty <| acceptablePeople model
    in
        if (showMenu) then
            div
                [ class "autocomplete-menu" ]
                [ (Html.map SetAutoState (Autocomplete.view viewConfig 10 model.autoState (acceptablePeople model))) ]
        else
            div [] []



-- setup for your autocomplete view


viewConfig : Autocomplete.ViewConfig Person
viewConfig =
    let
        customizedLi keySelected mouseSelected person =
            { attributes = [ classList [ ( "autocomplete-item", True ), ( "is-selected", keySelected || mouseSelected ) ] ]
            , children = [ Html.text person.name ]
            }
    in
        Autocomplete.viewConfig
            { toId = .name
            , ul = [ class "autocomplete-list" ]
            , li = customizedLi
            }


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
                [ onClick Form.Submit
                , class "ui primary button"
                ]
                [ text "Submit" ]
            ]
