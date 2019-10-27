module Main exposing (..)

import Browser
import GeneratedApi exposing (Priority, getPriorities)
import Html exposing (Html, button, div, h1, img, li, p, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { priorities : List Priority }


init : ( Model, Cmd Msg )
init =
    ( { priorities = [] }, getPriorities initPriorities )


initPriorities result =
    case result of
        Ok priorities ->
            SetPriorities priorities

        Err _ ->
            NoOp



---- UPDATE ----


type Msg
    = SetPriorities (List Priority)
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetPriorities priorities ->
            ( Model priorities, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello, Priorities!" ]
        , div []
            (List.map
                renderPriority
                model.priorities
            )
        ]


renderPriority : Priority -> Html Msg
renderPriority priority =
    li [] [ text (priority.name ++ " - " ++ String.fromInt priority.priorityLevel) ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
