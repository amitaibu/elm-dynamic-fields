module Pages.Form.Model exposing (emptyModel, Model, DynamicForm)

import Date exposing (Date, Day(..), day, dayOfWeek, month, year)
import Form exposing (Form)
import Form.Validate as Validate exposing (..)


type alias DynamicForm =
    { bar : String
    , baz : Bool
    , date : Date
    }



-- Add form to your model and msgs


type alias Model =
    { form : Form () DynamicForm
    }


validate : Validation () DynamicForm
validate =
    form3 DynamicForm
        (get "bar" email)
        (get "baz" bool)
        (get "date" date)


emptyModel : Model
emptyModel =
    { form = Form.initial [] validate
    }
