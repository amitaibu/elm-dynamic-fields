module App.View exposing (..)

import Config.View exposing (view)
import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Form.View exposing (..)
import RemoteData exposing (RemoteData(..), WebData)


view : Model -> Html Msg
view model =
    case model.config of
        Failure err ->
            Config.View.view

        _ ->
            div []
                [ div [ class "ui container main" ]
                    [ viewMainContent model
                    , pre [ class "ui padded secondary segment" ]
                        [ div [] [ text <| "pageFrom: " ++ toString model.pageForm ]
                        , div [] [ text <| "autocomplete: " ++ toString model.pageForm.autoState ]
                        ]
                    ]
                ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Form ->
            Html.map PageForm (Pages.Form.View.view model.pageForm)
