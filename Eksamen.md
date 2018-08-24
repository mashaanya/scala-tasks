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
