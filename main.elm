import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { content : String
   , content2 : String
   , content3 : String
  }


init : Model
init =
  { content = "" 
  , content2 = ""
  , content3 = ":"
  }



-- UPDATE


type Msg
  = Change String
  | ChangeString String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
    ChangeString secondcont ->
      { model | content2 = secondcont}



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "String1", value model.content, onInput Change ] []
    , input [ placeholder "String2", value model.content2, onInput ChangeString ] [] 
    , div [] [ text (model.content) , text (model.content3) , text (model.content2)]
    ]
