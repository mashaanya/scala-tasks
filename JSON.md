```scala
import org.json4s.jackson.JsonMethods.{compact, render}
import org.json4s.JsonDSL._
object JSON {
  def nameSurnameJSON(a:String,b:String,c:String,answer:String):String ={
    val serialized =
      ("name" -> a) ~
        ("surname"-> b)~
        ("number_of_task"-> c)~
        ("answer"->answer)
    compact(render(serialized))
  }
  ```
