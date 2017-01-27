module App exposing (..)

import Html exposing (div, button, text, h1, p, Html)
import Html.Events exposing (onClick)
import H2ioAppSkeleton


main : Program Never Model Msg
main =
    Html.program
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
    | H2ioAppSkeleton H2ioAppSkeleton.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Show ->
            let
                ( skeleton, skeletonCmd ) =
                    H2ioAppSkeleton.show model.skeleton
            in
                { model | skeleton = skeleton } ! [ Cmd.map H2ioAppSkeleton skeletonCmd ]

        H2ioAppSkeleton msg_ ->
            let
                ( skeleton_, cmd ) =
                    H2ioAppSkeleton.update msg_ model.skeleton
            in
                { model | skeleton = skeleton_ } ! []


model : Model
model =
    { skeleton = H2ioAppSkeleton.init
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Show ] [ text "Show Modal" ]
        , H2ioAppSkeleton.view H2ioAppSkeleton
            (H2ioAppSkeleton.modalContent appConfig model)
            model.skeleton
        ]
