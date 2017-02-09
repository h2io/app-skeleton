module H2ioAppSkeleton
    exposing
        ( Model
        , Msg
        , view
        , init
        , update
        , show
        , SkeletonList
        , modalContent
        , Size(..)
        , checkClose
        )

import H2ioModal exposing (Msg(..))
import Styles exposing (..)
import H2ioUi
import Html exposing (div, b, span, a, button, text, h1, p, Html)
import Html.Attributes exposing (style, href, target)
import String
import List exposing (map)
import InlineHover exposing (hover)


type alias Model =
    H2ioModal.Model


type alias Msg =
    H2ioModal.Msg


type alias ModalSize =
    { width : String
    , height : String
    }


type alias SkeletonList msg =
    { header : String
    , content : Html msg
    , footer : Maybe (Html msg)
    , footerLinks : Maybe (List FooterLinks)
    , size : Size
    }


type alias Name =
    String


type alias Link =
    String


type alias FooterLinks =
    ( Name, Link )


init : H2ioModal.Model
init =
    H2ioModal.init


show : H2ioModal.Model -> ( H2ioModal.Model, Cmd H2ioModal.Msg )
show model =
    H2ioModal.show model


view : (H2ioModal.Msg -> msg) -> H2ioModal.ViewModel msg -> H2ioModal.Model -> Html msg
view =
    H2ioModal.view


update : H2ioModal.Msg -> H2ioModal.Model -> ( H2ioModal.Model, Cmd H2ioModal.Msg )
update =
    H2ioModal.update


type Size
    = Small
    | Large


fromSize : Size -> ModalSize
fromSize size =
    case size of
        Small ->
            { width = "360px"
            , height = "500px"
            }

        Large ->
            { width = "480px"
            , height = "480px"
            }


defaultLinks : List FooterLinks
defaultLinks =
    [ ( "[±] h2.io", "https://h2.io" )
    , ( "Termeni & Condiții", "https://h2.io/termeni" )
    , ( "Confidențialitate", "https://h2.io/confidentialitate" )
    , ( "Cookies", "https://h2.io/cookies" )
    ]


footerEl : List FooterLinks -> Html msg
footerEl list =
    div []
        [ list
            |> map
                (\( name, link ) ->
                    hover linkStyleHover
                        a
                        [ href link
                        , target "_blank"
                        , styles linkStyle
                        ]
                        [ Html.text name, span [ styles linkStyle ] [ text " |" ] ]
                )
            |> div [ styles linksStyle ]
        ]


parse : SkeletonList msg -> a -> Html msg
parse skeleton model =
    let
        header =
            div []
                [ h1 [ styles headingStyle ]
                    [ H2ioUi.logo 42 []
                    , Html.text (String.fromChar ' ' ++ skeleton.header)
                    , Html.small [ styles smallStyle ]
                        [ Html.text "un serviciu "
                        , H2ioUi.logo 11
                            [ ( "color", "#91989b" ) ]
                        , Html.text " h2.io"
                        ]
                    ]
                ]

        footer =
            case skeleton.footer of
                Nothing ->
                    b [] []

                Just html ->
                    html

        footerLinks =
            case skeleton.footerLinks of
                Nothing ->
                    footerEl defaultLinks

                Just list ->
                    footerEl list
    in
        div
            [ style
                [ ( "all", "initial" )
                , ( "width", "100%" )
                , ( "height", "100%" )
                , ( "position", "absolute" )
                , ( "top", "0" )
                , ( "left", "0" )
                , ( "offset-inline-start", "0" )
                , ( "padding", "10px" )
                , ( "box-sizing", "border-box" )
                ]
            ]
            [ header
            , skeleton.content
            , footer
            , footerLinks
            ]


modalContent : SkeletonList msg -> a -> H2ioModal.ViewModel msg
modalContent list model =
    let
        { width, height } =
            fromSize list.size
    in
        { content = parse list model
        , width = width
        , height = height
        }


checkClose : Msg -> Bool
checkClose msg =
    if msg == (Close) then
        True
    else
        False
