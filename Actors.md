```scala
import akka.pattern.pipe
import akka.actor._
import akka.http.scaladsl.server.Directives.{complete, pathPrefix}
import akka.http.scaladsl.server.Route
import akka.pattern.{ask, pipe}
import akka.util.Timeout
import akka.http.scaladsl.server.PathMatchers.Remaining

import scala.collection._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global

case object Start

case class division(N: Double) {
}
class Actor1 extends Actor with ActorLogging {

  implicit val timeout = Timeout(5 seconds)
  val Actor2 = context.actorOf(Props(new Actor2), "Actor2")

  def receive ={
    case n:division if n.N-1==0  => log.error("Division by zero")
    case n:division =>
      val respF = Actor2 ! division(n.N / (n.N - 1))
      println(division(n.N / (n.N-1)))

    case n => log.warning("I dont know")


  }

}


class Actor2 extends Actor with ActorLogging {
  implicit val timeout = Timeout(5 seconds)
  val Actor3 = context.actorOf(Props(new Actor3), "Actor3")

  def receive = {
    case n: division if n.N - 1 == 0 => log.error("Division by zero")
    case n: division =>
      val respF =  Actor3 ! division(n.N / (n.N - 1))
    case n => log.warning("I dont know")
  }

  class Actor3 extends Actor with ActorLogging {

    def receive = {
      case n: division if n.N - 1 == 0 => log.error("Division by zero")
      case n: division =>
        val w = n.N / (n.N - 1)
        log.warning(s"$w")
      case n => log.warning("I dont know")
    }
    context.system.terminate()

  }

}
object three extends App {
  implicit val timeout = Timeout(5 seconds)
  val system = ActorSystem("system")
  val Actor1 = system.actorOf(Props(new Actor1), "Actor1")
  val rsstF = Actor1 ! division(7)


}
```
