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
  def receive = {
    case r: SetRequest =>
      mess += r.key -> r.value
      log.warning(s"current price: $r") 

    case r:bet if r.b.toInt >= mess(r.a).toInt =>
      log.warning(s"Sold: $r")
    case r:bet =>
      log.warning (s"The current price is higher")
    case r => log.warning(s"Unexpected: $r")

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
      //AucActor ! SetRequest("silver","15")
      val respF = AucActor ? bet("gold","120")
      respF pipeTo self



      context.system.terminate()
  }

}
object Main2 extends App{
  val system = ActorSystem("system")
  val mainActor = system.actorOf(Props(new MainActor), "mainActor")

}
```
