module App exposing (..)

import Html exposing (div, button, text, h1, p, Html)
import Html.Events exposing (onClick)
import Html.App as App
import H2ioAppSkeleton


main : Program Never
main =
    App.program
        { init = model ! []
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


appConfig : H2ioAppSkeleton.SkeletonList msg
appConfig =
    { header = "Example"
    , content = div [] []
    , footer = Nothing
    , footerLinks = Nothing
    , size = H2ioAppSkeleton.Small
    }


type alias Model =
    { skeleton : H2ioAppSkeleton.Model
    }


type Msg
    = NoOp
    | Show
    | H2ioAppSkeleton (H2ioAppSkeleton.Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Show ->
            { model | skeleton = H2ioAppSkeleton.show } ! []

        H2ioAppSkeleton msg' ->
            let
                ( skeleton', cmd ) =
                    H2ioAppSkeleton.update msg' model.skeleton
            in
                { model | skeleton = skeleton' } ! []


model : Model
model =
    { skeleton = H2ioAppSkeleton.model
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Show ] [ text "Show Modal" ]
        , H2ioAppSkeleton.view appConfig model.skeleton |> App.map H2ioAppSkeleton
        ]
