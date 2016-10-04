module H2ioAppSkeleton exposing (Model, model, SkeletonList, FooterLinks, update, Msg(Show), view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Task
import Svg
import List exposing (map)
import String
import Svg.Attributes exposing (..)
import Css exposing (..)
import H2ioModal exposing (modalModel)


--
-- main : Program Never
-- main =
--     App.program
--         { init = model ! [ config initialSkeleton ]
--         , update = update
--         , view = view
--         , subscriptions = subscriptions
--         }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Name =
    String


type alias Link =
    String


type alias FooterLinks =
    ( Name, Link )


type alias SkeletonList msg =
    { header : String
    , content : Html msg
    , footer : Maybe (Html msg)
    , footerLinks : Maybe (List FooterLinks)
    }


initialSkeleton : SkeletonList Msg
initialSkeleton =
    { header = ""
    , content = div [] []
    , footer = Nothing
    , footerLinks = Nothing
    }


type alias Model =
    { modal : H2ioModal.Model
    }


type Msg
    = NoOp
    | Show
    | H2ioModal (H2ioModal.Msg)


styles : List Css.Mixin -> Html.Attribute a
styles =
    Css.asPairs >> Html.Attributes.style


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Show ->
            let
                modal' =
                    H2ioModal.update H2ioModal.Show model.modal
            in
                { model | modal = modal' } ! []

        H2ioModal msg' ->
            let
                modal' =
                    H2ioModal.update msg' model.modal
            in
                { model | modal = modal' } ! []


msgToCmd : Msg -> Cmd Msg
msgToCmd msg =
    Task.perform (\_ -> Debug.crash "This failure cannot happen.")
        identity
        <| Task.succeed
        <| msg


modalConfig : H2ioModal.Model
modalConfig =
    { modalModel
        | width = "340px"
        , height = "480px"
    }


model : Model
model =
    { modal = modalConfig
    }


defaultLinks : List FooterLinks
defaultLinks =
    [ ( "[±] h2.io", "https://h2.io" )
    , ( "Termeni & Condiții", "https://h2.io/termeni" )
    , ( "Confidențialitate", "https://h2.io/confidentialitate" )
    , ( "Cookies", "https://h2.io/cookies" )
    ]


headingStyle : List Css.Mixin
headingStyle =
    [ all initial
    , Css.displayFlex
    , Css.margin3 (px 10) zero (px 25)
    , Css.fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , Css.fontSize (px 32)
    , Css.fontWeight bold
    , Css.color (hex "464b4d")
    , Css.textAlign center
    , Css.flexWrap Css.wrap
    ]


smallStyle : List Css.Mixin
smallStyle =
    [ all initial
    , Css.display block
    , Css.fontSize (px 13)
    , Css.letterSpacing (px 2)
    , Css.color (hex "91989b")
    , Css.fontFamilies [ (qt "Times New Roman"), "Times", "serif" ]
    , Css.fontWeight (int 400)
    , Css.textAlign center
    , Css.marginTop (px -10)
    , Css.width (pct 100)
    ]


linksStyle : List Css.Mixin
linksStyle =
    [ all initial
    , Css.display block
    , Css.width (pct 100)
    , Css.textAlign center
    , Css.position absolute
    , Css.bottom (px -25)
    , Css.left zero
    , Css.color (hex "f3f4f4")
    , Css.fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    ]


linkStyle : List Css.Mixin
linkStyle =
    [ all initial
    , Css.color (hex "bdc2c4")
    , Css.fontSize (px 11)
    , Css.fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , Css.cursor pointer
    , Css.paddingRight (px 5)
    , Css.lastOfType [ paddingRight zero ]
    ]


footerEl : List FooterLinks -> Html msg
footerEl list =
    div []
        [ list
            |> map
                (\( name, link ) ->
                    a
                        [ href link
                        , Html.Attributes.target "_blank"
                        , styles linkStyle
                        , Html.Attributes.style
                            [ ( "transition", ".2s ease color" )
                            , ( "will-change", "color" )
                            ]
                        ]
                        [ Html.text name ]
                )
            |> div [ styles linksStyle ]
        ]


parse : SkeletonList msg -> Html msg
parse skeleton =
    let
        header =
            div []
                [ h1
                    [ styles headingStyle
                    , Html.Attributes.style [ ( "justify-content", "center" ) ]
                    ]
                    [ Svg.svg
                        [ Svg.Attributes.width "40"
                        , Svg.Attributes.height "40"
                        , Html.Attributes.style
                            [ ( "fill", "#379ac4" )
                            , ( "display", "inline-block" )
                            , ( "vertical-align", "text-top" )
                            ]
                        ]
                        [ Svg.path [ d "M1 1h5v38H1z" ] []
                        , Svg.path [ d "M1 1h10v5H1zM1 34h10v5H1zM34 1h5v38h-5z" ] []
                        , Svg.path [ d "M29 1h10v5H29zM29 34h10v5H29zM10 28h20v5H10zM17 6h6v20h-6z" ] []
                        , Svg.path [ d "M10 13h20v6H10z" ] []
                        ]
                    , Html.text (String.fromChar ' ' ++ skeleton.header)
                    , Html.small [ styles smallStyle ]
                        [ Html.text "un serviciu [±] h2.io" ]
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
        div []
            [ header
            , skeleton.content
            , footer
            , footerLinks
            ]


view : SkeletonList H2ioModal.Msg -> Model -> Html Msg
view list model =
    let
        modal' =
            model.modal

        newContent =
            { modal' | content = parse list }
    in
        div []
            [ H2ioModal.view newContent |> App.map H2ioModal
            ]
