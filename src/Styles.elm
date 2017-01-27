module Styles exposing (..)

import Css exposing (..)
import Html.Attributes exposing (style)
import Html


styles : List Css.Mixin -> Html.Attribute a
styles =
    Css.asPairs >> Html.Attributes.style


headingStyle : List Css.Mixin
headingStyle =
    [ all initial
    , displayFlex
    , margin3 (px 10) zero (px 25)
    , fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , fontSize (px 32)
    , fontWeight bold
    , color (hex "464b4d")
    , textAlign center
    , flexWrap wrap
    , property "justify-content" "center"
    ]


smallStyle : List Css.Mixin
smallStyle =
    [ all initial
    , display block
    , fontSize (px 13)
    , letterSpacing (px 2)
    , color (hex "91989b")
    , fontFamilies [ (qt "Times New Roman"), "Times", "serif" ]
    , fontWeight (int 400)
    , textAlign center
    , marginTop (px -10)
    , width (pct 100)
    ]


linksStyle : List Css.Mixin
linksStyle =
    [ all initial
    , display block
    , width (pct 100)
    , textAlign center
    , position absolute
    , bottom (px -25)
    , left zero
    , color (hex "f3f4f4")
    , fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , property "offset-block-end" "-25px"
    ]


linkStyle : List Css.Mixin
linkStyle =
    [ all initial
    , color (hex "bdc2c4")
    , fontSize (px 11)
    , fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , cursor pointer
    , paddingRight (px 5)
    , lastOfType [ paddingRight zero ]
    , property "transition" ".2s ease color"
    , property "will-change" "color"
    ]


linkStyleHover : List ( String, String )
linkStyleHover =
    [ ( "color", "#f3f4f4" ) ]
