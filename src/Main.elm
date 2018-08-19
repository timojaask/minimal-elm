module Main exposing (..)
import Html exposing (Html, text, div)

type alias Model = {}

init : ( Model, Cmd Msg )
init = ( {}, Cmd.none )

type Msg = NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = ( model, Cmd.none )

view : Model -> Html Msg
view model = div [] [ text "Hello, World!" ]

main : Program Never Model Msg
main =
  Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = always Sub.none
    }