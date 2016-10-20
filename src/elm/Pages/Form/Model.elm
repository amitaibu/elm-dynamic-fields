module Pages.Form.Model exposing (emptyModel, Model, DynamicForm)

import Form exposing (Form)
import Form.Validate as Validate exposing (..)


type alias DynamicForm =
    { bar : String
    , baz : Bool
    }



-- Add form to your model and msgs


type alias Model =
    { dynamic : Int
    , form : Form () DynamicForm
    }


validate : Validation () DynamicForm
validate =
    form2 DynamicForm
        (get "bar" email)
        (get "baz" bool)


emptyModel : Model
emptyModel =
    { dynamic = 1
    , form = Form.initial [] validate
    }
