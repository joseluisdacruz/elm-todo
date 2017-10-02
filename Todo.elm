module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { texto : String
    , todoList : List String
    }


model : Model
model =
    { texto = ""
    , todoList = []
    }


type Msg
    = Texto String
    | Inserir
    | Remover String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Texto t ->
            { model | texto = t }

        Inserir ->
            if not (List.any ((==) model.texto) model.todoList) then
                { model | todoList = model.texto :: model.todoList, texto = "" }
            else
                model

        Remover t ->
            { model | todoList = List.filter ((/=) t) model.todoList }


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", onInput Texto, placeholder "Inserir todo" ] []
        , input [ type_ "button", onClick Inserir, value "Inserir", disabled (model.texto == "") ] []
        , div []
            [ ul [] (List.map todoItem model.todoList)
            ]
        ]


todoItem : String -> Html Msg
todoItem conteudo =
    li [] [ text conteudo, text " ", button [ onClick (Remover conteudo) ] [ text "X" ] ]
