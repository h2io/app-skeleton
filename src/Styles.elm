module Styles exposing (..)


type alias StandarcCss =
    List ( String, String )


headingStyle : StandarcCss
headingStyle =
    [ ( "all", "initial" )
    , ( "display", "flex" )
    , ( "margin", "10px 0 25px" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "font-size", "32px" )
    , ( "font-weight", "bold" )
    , ( "color", "#464b4d" )
    , ( "flex-wrap", "wrap" )
    , ( "text-align", "center" )
    , ( "justify-content", "center" )
    ]


smallStyle : StandarcCss
smallStyle =
    [ ( "all", "initial" )
    , ( "display", "block" )
    , ( "font-size", "13px" )
    , ( "letter-spacing", "2px" )
    , ( "color", "#91989b" )
    , ( "font-family", "'Times New Roman', serif" )
    , ( "fontWeight", "400" )
    , ( "text-align", "center" )
    , ( "margin-top", "-10px" )
    , ( "width", "100%" )
    ]


linksStyle : StandarcCss
linksStyle =
    [ ( "all", "initial" )
    , ( "display", "block" )
    , ( "width", "100%" )
    , ( "text-align", "center" )
    , ( "position", "absolute" )
    , ( "bottom", "-25px" )
    , ( "left", "0" )
    , ( "color", "#f3f4f4" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "offset-block-end", "-25px" )
    ]


linkStyle : StandarcCss
linkStyle =
    [ ( "all", "initial" )
    , ( "color", "#bdc2c4" )
    , ( "font-size", "11px" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "cursor", "pointer" )
    , ( "padding-right", "5px" )
    , ( "transition", ".2s ease color" )
    , ( "will-change", "color" )
    ]



-- , lastOfType [ paddingRight zero ]


linkStyleHover : StandarcCss
linkStyleHover =
    [ ( "color", "#f3f4f4" ) ]
