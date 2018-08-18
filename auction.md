```scala
import akka.actor._
import akka.pattern.{ask, pipe}
import akka.util.Timeout

import scala.collection._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global
case class SetRequest(key: String, value: String){



}


case class bet(a:String,b:String){

}

case object Start
class AucActor extends Actor with ActorLogging{
  val mess: mutable.Map[String,String] = mutable.Map.empty
  var beta = 0
  def receive = {

    case i: SetRequest =>
      mess += i.key -> i.value
      log.warning(s"current price: $i")
      var beta = mess(i.key).toInt
    case i: bet =>
      bet(i.a, i.b) match {
        case i: bet if i.b.toInt >= mess(i.a).toInt =>
          log.warning(s"Sold: $i")
          mess -= i.a
          beta = 0
        case i: bet if i.b.toInt >= beta =>
          beta = i.b.toInt
          log.warning(s"You cannot buy it; current price $beta")
        case i: bet =>
          log.warning(s"The current price is higher")
        case i => log.warning(s"Unexpected: $i")

      }


      if (mess.isEmpty) context.system.terminate()
  }



  }



class MainActor extends Actor with ActorLogging{
  implicit val timeout = Timeout(5 seconds)
  val AucActor = context.actorOf(Props(new AucActor), "AucActor")
  override def preStart() {
    self ! Start
  }
  def receive =  {
    case Start =>
      AucActor ! "dummy request"
      AucActor ! SetRequest("gold", "100")
      AucActor ! SetRequest("silver","15")
      val respF = AucActor ? bet("gold","90")
      respF pipeTo self
      val raspF = AucActor ? bet ("gold", "120")
      raspF pipeTo self
      val rospF = AucActor ? bet ("silver", "10")
      rospF pipeTo self


  }

}
object Main2 extends App{
  val system = ActorSystem("system")
  val mainActor = system.actorOf(Props(new MainActor), "mainActor")
  //system.awaitTermination()
}

```
