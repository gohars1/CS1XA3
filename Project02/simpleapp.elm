import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url
import Random

type Msg = Tick Float GetKeyState
         | MakeRequest Browser.UrlRequest
         | UrlChange Url.Url
         | IncreaseGrape
         | DecreaseGrape
         | TotalWeight
         | IncreaseApple
         | DecreaseApple
         | IncreaseBanana
         | DecreaseBanana
         | IncreasePlum
         | DecreasePlum
         | IncreaseWatermelon
         | DecreaseWatermelon
         | SetBalance
         | NewVal Fractions
         | CheckSides
         | MoveBalance
         | Reset

       

type Fruits = Grapes 
            | Apples
            | Bananas 
            | Plum 
            | Watermelon
            | None

type Fractions = FiveHalves
               | TenThirds
               | FiveFourths
               | SixThirds
               | SeventeenTwelveths
               | TwentyThreeSixths
               | ElevenTwelveths 
               | Null
               



type alias Model = { fruits : List String , weight : Float , status : Fractions , result : String , state : Bool }-- create record 

init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url getKeystate = ( {weight = 0, fruits = [] , status = Null , result = "" , state = False  } , Cmd.none )-- add init model

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
                     Tick time keystate -> (model ,Cmd.none)
                     MakeRequest req    -> (model ,Cmd.none)
                     UrlChange url      -> (model ,Cmd.none)
                     IncreaseGrape           -> ( { model | fruits = nameFruit Grapes :: model.fruits } , Cmd.none)
                     DecreaseGrape           -> ( { model | fruits = removeOne Grapes model.fruits }, Cmd.none)
                     IncreaseApple           -> ( { model | fruits = nameFruit Apples :: model.fruits } , Cmd.none)
                     DecreaseApple           -> ( { model | fruits = removeOne Apples model.fruits }, Cmd.none)
                     IncreaseBanana          -> ( { model | fruits = nameFruit Bananas :: model.fruits }, Cmd.none)
                     DecreaseBanana          -> ( { model | fruits = removeOne Bananas model.fruits}, Cmd.none)
                     IncreasePlum          -> ( { model | fruits = nameFruit Plum :: model.fruits }, Cmd.none)
                     DecreasePlum          -> ( { model | fruits = removeOne Plum model.fruits}, Cmd.none)
                     IncreaseWatermelon          -> ( { model | fruits = nameFruit Watermelon :: model.fruits }, Cmd.none)
                     DecreaseWatermelon          -> ( { model | fruits = removeOne Watermelon model.fruits}, Cmd.none)
                     TotalWeight             -> ( { model | weight = totalWeight model.fruits}, Cmd.none)
                     SetBalance              -> ( model , Random.generate NewVal fractionGenerate )
                     NewVal newVal           -> ( { model | status = newVal} , Cmd.none)
                     CheckSides              -> ( { model | result = checkequal (model.weight) (fractionval model.status)}, Cmd.none) 
                     MoveBalance             -> ( { model | state = if model.result == "You got it! Try a different weight now" then True else False } ,Cmd.none)
                     Reset                   -> ( { model | weight = 0 , fruits = [] , result = "", state = False}, Cmd.none)
view : Model -> { title : String, body : Collage Msg }
view model = 
    let 
        title = "Balanced Diet"
        body = collage 500 500 [
                                grapes
                                |> notifyTap IncreaseGrape
                                |> notifyTap TotalWeight
                                |> scaleX (1/2) 
                                |> scaleY (1/2)
                                |> move (-238, -185)

                                ,
                                text ("List: " ++ String.concat model.fruits)
                                |> filled blue
                                |> move (-250, -150)
                                ,
                                text ("Click on one of the fruits below to add fruits to your list")
                                |> filled blue
                                |> move (-250, -130)
                                ,
                                grapes
                                |> notifyTap DecreaseGrape
                                |> move (335, 530)
                                |> notifyTap TotalWeight
                                |> scaleX (1/3)
                                |> scaleY (1/3)
                                ,
                                apples
                                |> notifyTap IncreaseApple
                                |> notifyTap TotalWeight
                                |> move (-300, -400)
                                |> scaleX (1/2)
                                |> scaleY (1/2)
                                ,
                                apples
                                |> notifyTap DecreaseApple
                                |> notifyTap TotalWeight
                                |> move (250,500)
                                |> scaleX (1/3) 
                                |> scaleY (1/3)
                                ,
                                scale2
                                ,
                                scalepart
                                |> if model.state == False then rotate ( degrees 15) else rotate (degrees 0)
                                ,
                                newvalButton
                                |> notifyTap SetBalance
                                |> notifyTap Reset
                                |> move (170,-60)
                                ,
                                text ( displayfract model.status)
                                |> filled blue
                                |> scaleX 2
                                |> scaleY 2
                                |> if model.state == False then move (-130, -2) else move (-127,25)
                                
                                ,
                                buttoncheck
                                |> notifyTap CheckSides
                                |> notifyTap MoveBalance
                                |> move ( 170, 0)
                                ,
                                text (model.result)
                                |> filled blue
                                |> move (60, -30 )
                                ,
                                bananas
                                |> notifyTap IncreaseBanana
                                |> notifyTap TotalWeight
                                |> scaleX 2
                                |> scaleY 2
                                |> move (-70, -190)
                                ,
                                bananas 
                                |> notifyTap DecreaseBanana
                                |> notifyTap TotalWeight
                                |> scaleX 1.2
                                |> scaleY 1.2
                                |> move (34, 167)
                                ,
                                plum
                                |> notifyTap IncreasePlum
                                |> notifyTap TotalWeight
                                |> move ( 0 , -200)                                       
                                ,
                                watermelon
                                |> notifyTap IncreaseWatermelon
                                |> notifyTap TotalWeight
                                |> move (100, -190)
                                ,
                                plum
                                |> scaleX (4/5)
                                |> scaleY (4/5)
                                |> notifyTap DecreasePlum
                                |> notifyTap TotalWeight
                                |> move (170, 166)
                                ,
                                watermelon
                                |> scaleX (1/2)
                                |> scaleY (1/2)
                                |> notifyTap DecreaseWatermelon
                                |> notifyTap TotalWeight
                                |> move (220, 168)
                                ,
                                fruitPile
                                |> scaleX (1/3)
                                |> scaleY (1/3)
                                |> if model.state == True && model.status /= Null then move (110,30) else move (-500,0)
                                
                                ,
                                text (" If you have a fruit in your list that you want to remove, click on the fruit below!")
                                |> filled blue
                                |> move (-140, 220)
                                ,
                                text (" 1/2 kg              1/3 kg                   2/3 kg           1/4 kg                         1 kg")
                                |> filled black
                                |> move(-240, -240)
                        
                                ,
                                text (" Add fruits to your list ")
                                |> filled blue
                                |> move (-250, 30)
                                ,
                                text (" so that the weight is ")
                                |> filled blue
                                |> move (-250, 10)
                                ,
                                text (" equal to the number")
                                |> filled blue
                                |> move (-250 , -10)                   
                                ,
                                text (" here")
                                |> filled blue
                                |> move (-250 , -30)       
                               ]
  in { title = title , body = body }

{- Functions for handling Fruit and Fraction types so that their values are usable for
different operations
-}

checkequal : Float -> Float -> String
checkequal f b = if f - b <= 0.01 && f - b >= -0.01 then
                    "You got it! Try a different weight now"
                 else
                    "                  Incorrect, keep trying!"

numToFract : Int -> Fractions
numToFract num = case num of 
                 0 -> TenThirds 
                 1 -> FiveFourths
                 2 -> SixThirds
                 3 -> SeventeenTwelveths
                 4 -> TwentyThreeSixths
                 5 -> FiveHalves
                 6 -> ElevenTwelveths
                 _ -> Null
                 

fractionGenerate : Random.Generator Fractions
fractionGenerate =
        Random.map numToFract (Random.int 0 6)

fractionval : Fractions -> Float
fractionval fraction = case fraction of 
                       TenThirds -> 10/3
                       FiveFourths -> 5/4
                       SixThirds   -> 6/3
                       SeventeenTwelveths  -> 17/12
                       TwentyThreeSixths -> 23/6
                       FiveHalves        -> 5/2
                       ElevenTwelveths      -> 11/12
                       Null              -> 0
                      
displayfract : Fractions -> String
displayfract fraction = case fraction of
                        TenThirds -> "10/3 kg"
                        FiveFourths -> "5/4 kg"
                        SixThirds   -> "6/3 kg"
                        SeventeenTwelveths  -> "17/12 kg"
                        TwentyThreeSixths -> "23/6 kg "
                        FiveHalves        -> "5/2 kg "
                        ElevenTwelveths      -> "11/12 kg"
                        Null              -> "0 kg"
                      


totalWeight : List String -> Float
totalWeight fruits  = -- sum <| map weight fruits
                      case fruits of
                      (f::fs) -> fruitWeight (undoName f) + totalWeight fs
                      [] -> 0

fruitWeight : Fruits -> Float
fruitWeight fruit = case fruit of
                    Grapes -> 1/2
                    Apples -> 1/3
                    Bananas -> 2/3
                    Plum    -> 1/4
                    Watermelon -> 1
                    None   -> 0
nameFruit : Fruits -> String
nameFruit fruit = case fruit of
                  Grapes -> "Grapes, "
                  Apples  -> "Apple, "
                  Bananas -> "Bananas, "
                  Plum    -> "Plum, "
                  Watermelon -> "Watermelon, "
                  None   -> ""
undoName : String -> Fruits
undoName s = case s of 
            "Grapes, " -> Grapes
            "Apple, "  -> Apples
            "Bananas, " -> Bananas
            "Plum, "   -> Plum
            "Watermelon, " -> Watermelon
            _          -> None
removeOne : Fruits -> List String -> List String
removeOne fruit frulist = case frulist of
                      (x::xs) -> if x == nameFruit fruit then xs else x :: removeOne fruit xs
                      [] -> []

-- Functions for random generation
--balanceval = Random.float 0 5
-- Functions to render graphical display of fruit types
buttoncheck = group [
    rect 80 20
    |> filled lightGreen
    ,
    text (" Test ")
    |> filled black
    |> move (-15 , -5)
 ]

newvalButton = group [
                          rect 80 20
                          |> filled lightBlue 
                          
                          ,
                          text ("New Weight")
                          |> filled black
                          |> move (-30, -5)
 ]

fruitPile = group [
                    watermelon
                    |> scale 1.5
                    |> move (0 , 10),
                    bananas
                    |> scaleX 3
                    |> scaleY 3,
                    apples
                    |> scaleX (1/2)
                    |> scaleY (1/2)
                    ,
                    grapes
                    |> scaleX (3/4)
                    |> scaleY (3/4)
                    |> rotate (degrees 45)
                    |> move (20,0)
                    ,
                    plum
                    |> move (-50, 0)
                    
 ]

bananas = group [ oval 30 5
                  |> filled yellow
                  |> rotate (degrees 315)
                  ,
                  oval 30 5
                  |> filled yellow
                  |> rotate (degrees 325)
                  |> move ( 4 , 4)
                  ,
                  oval 30 5 
                  |> filled yellow
                  |> rotate ( degrees 305)
                  |> move (-4,-4)
                  ,
                  circle 4
                  |> filled brown
                  |> move (-11, 12)
                 


                ]

plum   = group [ 
                    circle 20
                    |> filled purple
                    |> move (0, 0)
                    ,
                    rect 5 10
                    |> filled brown 
                    |> move ( 0 , 20)
                    ,
                    oval 5 10
                    |> filled green
                    |> rotate (degrees 40)
                    |> move (-5 , 20)
                    
                
 ]

watermelon = group [
                    
                    oval 120 70
                    |> filled lightGreen
                    ,
                    oval 118 10 
                    |> filled darkGreen
                    ,
                    oval 98 10
                    |> filled darkGreen
                    |> move ( 0 , 20)
                    ,
                    oval 98 10
                    |> filled darkGreen
                    |> move ( 0 , -20)
                    
                  


                   ]

grapes = group [ 
                rect 20 40
                |> filled lightGreen
                |> move (28, 20)
                ,
                circle 10
                |> filled purple
                |> move (-10,0)
                ,
                circle 10
                |> filled purple
                |> move (28,0)
                ,
                circle 10
                |> filled purple
                |> move (9, -10)
                ,
                circle 10
                |> filled purple
                |> move (45, -10)
                ,
                circle 10
                |> filled purple 
                |> move (27 ,-20)
                ,
                circle 10
                |> filled purple
                |> move (27 , -38)
                ,
                circle 10
                |> filled purple
                |> move (66,0)
                ,
                circle 10
                |> filled purple
                |> move (9,-30)
                ,
                circle 10
                |> filled purple
                |> move (47,-30)
                ,
                circle 10
                |> filled purple
                |> move (28,-60)
                
             
                ]
apples = group [
                 circle 50
                 |> filled red
                 |> move (0,0)
                 ,
                 rect 10 20
                 |> filled brown
                 |> move (0, 60)
                 ,
                 oval 40 20
                 |> filled green
                 |> move (0, 60)
                 |> rotate (degrees 45)
                 |> move (60 , 20)
                

               ]
-- Functions to display Balance Scale
scale2 = group [
               rect 30 250
               |> filled brown
               |> move (0, 30)
               
                             
               
               
               
            ]
scalepart =
                  group [
                  
                   triangle 40
                   |> outlined (solid 5) brown 
                   |> rotate (degrees 90)
                   |> move ( 108 ,35 )
                   ,
                    triangle 40
                   |> outlined (solid 5) brown 
                   |> rotate (degrees 90)
                   |> move ( -108 ,35 )
                   
                   ,
                   rect 240 10
                   |> filled brown
                   |> move (0,85) 
               
                  ] 


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : AppWithTick () Model Msg
main = appWithTick Tick
       { init = init
       , update = update
       , view = view
       , subscriptions = subscriptions
       , onUrlRequest = MakeRequest
       , onUrlChange = UrlChange
       }  
