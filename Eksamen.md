Kittens
```scala

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.model._
import akka.http.scaladsl.server.Directives._
import akka.stream.ActorMaterializer

import scala.io.StdIn
import akka.http.scaladsl.server.Route
import org.json4s.jackson.JsonMethods.{compact, render}
import org.json4s.JsonDSL._

import scala.collection.mutable.ListBuffer

import Take._
import Mate._

import scala.concurrent.ExecutionContext.Implicits.global
case class Cat(name: String, isMale: Boolean, breed: String, age: Int)



object Eksamen extends App {
  val l: ListBuffer[Cat] = ListBuffer()
  implicit val system1 = ActorSystem("my-system")
  implicit val executionContext = system1.dispatcher

  implicit val materializer = ActorMaterializer()

  val route =
    pathPrefix("add") {
      Add(l)
    } ~ pathPrefix("take") {
      Take(l)
    } ~ pathPrefix("mate") {
      Mate(l)
    }


  val bindingFuture = Http().bindAndHandle(route, "localhost", 8080)

  println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
  StdIn.readLine() // let it run until user presses return
  bindingFuture
    .flatMap(_.unbind()) // trigger unbinding from the port
    .onComplete(_ => system1.terminate()) // and shutdown when done

}

import akka.http.scaladsl.server.Directives.{complete, pathPrefix}
import akka.http.scaladsl.server.PathMatchers.Remaining
import scala.concurrent.ExecutionContext.Implicits.global
import akka.http.scaladsl.server.PathMatchers.Remaining
import akka.http.scaladsl.server.Route
import scala.collection.mutable.ListBuffer
object Add {
  def apply(orders: ListBuffer[Cat]): Route ={
    pathPrefix(Remaining) { n: String =>
      val a = n.split("_").toList

      val cat: Cat = Cat(a(0), a(1).toBoolean, a(2), a(3).toInt)
      orders+=cat
      complete(s"Success:You add the cat $n")
    }
  }
}
import akka.http.scaladsl.server.Directives.{complete, pathPrefix}
import akka.http.scaladsl.server.PathMatchers.Remaining
import scala.concurrent.ExecutionContext.Implicits.global
import akka.http.scaladsl.server.PathMatchers.Remaining
import akka.http.scaladsl.server.Route
import Cat._
import scala.util.Random
import scala.collection.mutable.ListBuffer
object Mate{
  def apply(orders: ListBuffer[Cat]): Route ={
    pathPrefix(Remaining) { n: String =>
      val a = n.split("_").toList
      val couple:ListBuffer[Cat] = ListBuffer()
      orders.toList match {
        case i::Nil if (i.name == a(0)) || (i.name==a(1)) => couple+=i
        case i::Nil => couple
        case i::tail if (i.name == a(0)) || (i.name==a(1)) => couple+=i
        case i::tail => couple
        case _ => throw new Exception
      }
      val r = scala.util.Random
      var p = ""
      if (r.nextBoolean()) { p = couple.head.breed}
      else {p = couple.last.breed}

      val kitten:Cat = Cat(a.last,r.nextBoolean,p,0)
      orders.to[ListBuffer]
      orders += kitten
      complete(s"Success: You have a new Kitten $kitten")
    }
  }
}
import akka.http.scaladsl.server.Directives.{complete, pathPrefix}
import akka.http.scaladsl.server.PathMatchers.Remaining
import scala.concurrent.ExecutionContext.Implicits.global
import akka.http.scaladsl.server.PathMatchers.Remaining
import akka.http.scaladsl.server.Route
import Cat._

import scala.collection.mutable.ListBuffer
object Take{
  def apply(orders: ListBuffer[Cat]): Route ={
    pathPrefix(Remaining) { n: String =>
      val a = n.split("_").toList
      val cat: Cat = Cat(a(0), a(1).toBoolean, a(2), a(3).toInt)
      if (orders.contains(cat)) {
        orders -= cat
        complete(s"Success:You take the cat $n")}
      else complete(s"Fail: You cannot take $n ")
    }
  }
}

```
Actors
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
case class are_you_telegram()
case object Start
class ActorRCO extends Actor with ActorLogging {
  implicit val timeout = Timeout(5 seconds)
  val system = ActorSystem("system")
  val Actor1 = system.actorOf(Props(new Actor1), "Actor1")
  val Actor2 = system.actorOf(Props(new Actor2), "Actor2")
  val Actor3 = system.actorOf(Props(new Actor3), "Actor3")
  def receive ={
    case Start =>
      val res= Actor1 ? are_you_telegram()
      res pipeTo self
      Actor1 ! PoisonPill
      val ras = Actor2 ? are_you_telegram()
      ras pipeTo self
      Actor2 ! PoisonPill
      val ros = Actor3 ? are_you_telegram()
      ros pipeTo self
      Actor3 ! PoisonPill
      
    case _ => throw new Exception
  }

}
class Actor1 extends Actor with ActorLogging{
  def receive ={
    case i:are_you_telegram => log.warning("Yes")
  }
}
class Actor2 extends Actor with ActorLogging{
  def receive ={
    case i:are_you_telegram => log.warning("No")
  }
}
class Actor3 extends Actor with ActorLogging{
  def receive ={
    case i:are_you_telegram => log.warning("Yes")
  }
}
object RCO extends App {
  implicit val timeout = Timeout(5 seconds)
    val system = ActorSystem("system")
    val ActorRCO = system.actorOf(Props(new ActorRCO), "ActorRCO")
    ActorRCO ! Start



}
```
