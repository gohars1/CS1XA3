module Main exposing (main)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import String
import Json.Decode as JDecode
import Json.Encode as JEncode
-- MAIN

--rootUrl = "http://localhost:8000/e/gohars1/"
main =
  Browser.element { init = init, update = update, view = view, subscriptions= \_->Sub.none }
-- MODEL
type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , get_response: String
  , post_response: String
  , error_response: String
  }
--this is the correct syntax for making a model, need to specify the name of the variable and its value

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "" "" "" "Waiting to make request" "Waiting to make request" ""{-{ name="",password= "",passwordAgain= "", get_response = "Waiting to make request"
                     , post_response = "Waiting to make request"
                     , error_response = ""
    }-}
    , Cmd.none
  )
-- UPDATE
type Msg
  = Name String
  | Password String
  | PasswordAgain String
  -- | GetResponse (Result Http.Error String) -- Http Get Response recieved
  | PostResponse (Result Http.Error String) -- Http Post Response recieved
  -- | GetButton -- get buttons is pressed
  | PostButton -- post button is pressed
--the type was worng, compare to previeous version
--also added cases for when pressing the button, very important

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Name val ->
      ({model | name = val}, Cmd.none)
    Password val ->
      ({model | password = val}, Cmd.none)
    PasswordAgain val ->
      ({model | passwordAgain  = val}, Cmd.none)
    -- GetResponse result ->
    --   case result of
    --     Ok val ->
    --       ({model | get_response = val, error_response = ""}, Cmd.none)
    --     Err error ->
    --       (handleError model error, Cmd.none)
    PostResponse result ->
      case result of
        Ok val ->
          ({model | post_response = val, error_response = ""}, Cmd.none)
        Err error ->
          (handleError model error, Cmd.none)
    -- button presses
    PostButton ->
      (model, performPost model)
    -- GetButton ->
    --   (model, performGet model)
-- VIEW
-- view was also bad, need to put all divs inside a bigger one

view : Model -> Html Msg
view model =
  div [] [
  div []
        [ div []
            [ text model.get_response
            -- , button [ onClick GetButton ] [ text "Perform Get" ]
            ]
        , div
            []
            [ text model.post_response
            , button [ onClick PostButton ] [ text "Perform Post" ]
            ]
        , div [] [ text model.error_response ]
        ],
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]
  ]

viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html Msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
-- this didn't exist, needs to be changed

rootUrl : String
rootUrl =
        "https://mac1xa3.ca/e/gohars1/lab7/"   --"127.0.0.1/"

--changed post and get to actually use current model, but I advise to not use get for pass and name, I commented out all the get related things
-- performGet : Model -> Cmd Msg
-- performGet model =
--     Http.get
--         { url = rootUrl ++ "testreq/testget/?name=" ++ model.name  ++ "&pass=" ++ model.password ++ "&passAgain=" ++ model.passwordAgain
--         , expect = Http.expectString GetResponse
--         }

modelEncoder : Model -> JEncode.Value
modelEncoder model =
    JEncode.object
        [ ( "name"
          , JEncode.string model.name
          )
        , ( "lastname"
          , JEncode.string model.password
          )
        ]

performPost : Model -> Cmd Msg
performPost model =
    Http.post
        { url = rootUrl ++ "passwd/validate/"
        , body = Http.jsonBody <| modelEncoder model
        , expect = Http.expectString PostResponse
        }
        
handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | error_response = "bad url: " ++ url }
        Http.Timeout ->
            { model | error_response = "timeout" }
        Http.NetworkError ->
            { model | error_response = "network error" }
        Http.BadStatus i ->
            { model | error_response = "bad status " ++ String.fromInt i }
        Http.BadBody body ->
            { model | error_response = "bad body " ++ body }
