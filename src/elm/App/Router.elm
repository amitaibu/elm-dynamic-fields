module App.Router exposing (delta2url, location2messages)

import App.Model exposing (..)
import App.Update exposing (..)
import Config exposing (configs)
import Dict exposing (..)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), UrlChange)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Form ->
            Just <| UrlChange NewEntry "/#form"


location2messages : Location -> List Msg
location2messages location =
    let
        cmd =
            case location.hash of
                _ ->
                    [ SetActivePage Form ]
    in
        getConfigFromLocation location :: cmd



-- @todo: We calcualte the config over and over again. It's not expensive
-- but redundent.


getConfigFromLocation : Location -> Msg
getConfigFromLocation location =
    case (Dict.get location.hostname configs) of
        Just val ->
            SetConfig val

        Nothing ->
            SetConfigError
