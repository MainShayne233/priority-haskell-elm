module GeneratedApi exposing(..)

import Json.Decode
import Json.Encode exposing (Value)
-- The following module comes from bartavelle/json-helpers
import Json.Helpers exposing (..)
import Dict exposing (Dict)
import Set
import Http
import String
import Url.Builder

maybeBoolToIntStr : Maybe Bool -> String
maybeBoolToIntStr mx =
  case mx of
    Nothing -> ""
    Just True -> "1"
    Just False -> "0"

type alias Priority  =
   { id: Int
   , name: String
   , priorityLevel: Int
   }

jsonDecPriority : Json.Decode.Decoder ( Priority )
jsonDecPriority =
   Json.Decode.succeed (\pid pname ppriorityLevel -> {id = pid, name = pname, priorityLevel = ppriorityLevel})
   |> required "id" (Json.Decode.int)
   |> required "name" (Json.Decode.string)
   |> required "priorityLevel" (Json.Decode.int)

jsonEncPriority : Priority -> Value
jsonEncPriority  val =
   Json.Encode.object
   [ ("id", Json.Encode.int val.id)
   , ("name", Json.Encode.string val.name)
   , ("priorityLevel", Json.Encode.int val.priorityLevel)
   ]


getPriorities : (Result Http.Error  ((List Priority))  -> msg) -> Cmd msg
getPriorities toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "priorities"
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.list (jsonDecPriority))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }
