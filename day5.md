```scala
import com.sun.net.httpserver.Authenticator.{Failure, Success}

import scala.concurrent._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global
import com.typesafe.scalalogging.LazyLogging
import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.model._
import akka.http.scaladsl.server.Directives._
import akka.stream.ActorMaterializer
import akka.http.scaladsl.server.Route

import scala.io.StdIn
import org.json4s.jackson.JsonMethods.{compact, render}
import org.json4s.JsonDSL._
import JSON.nameSurnameJSON

object Main extends App  {

  implicit val system = ActorSystem("my-system")
  implicit val materializer = ActorMaterializer()
  // needed for the future flatMap/onComplete in the end
  implicit val executionContext = system.dispatcher

  val route =
    pathPrefix ("task1"){
      nameRoute()
    }~ pathPrefix("task2"){
      Hi()
    }~pathPrefix("task3"){
      Hey()
    }





  val bindingFuture = Http().bindAndHandle(route, "localhost", 8080)

  println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
  StdIn.readLine() // let it run until user presses return
  bindingFuture
    .flatMap(_.unbind()) // trigger unbinding from the port
    .onComplete(_ => system.terminate()) // and shutdown when done

}
object nameRoute {

  def f(a: Int, n: Int, l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, n, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, n, l, d - 1)
    else l

  }

  def nthGreatestDivisior(a: Int, n: Int) = {
    val d = a
    val l = f(a, n, List(), d)
    val p = l.reverse
    val w = p.take(n)
    w.last
  }


  val d1 = nthGreatestDivisior(12, 3).toString



  def apply(): Route = pathPrefix(Remaining) { name: String =>


    complete(nameSurnameJSON("Ann", "Sivokhina", "task1", d1))


  }
}
object Hi {
  def sumOfDigits(a: Int, s: Int): Int = {
    if (a > 10) sumOfDigits(a / 10, s + (a % 10)) else (s + a)
  }
  val d2 = sumOfDigits(25, 0).toString
  def apply():Route = pathPrefix(Remaining) { name:String =>
    complete(nameSurnameJSON("Ann", "Sivokhina", "task2", d2))
  }
}
object Hey {

  def f(a: Int,  l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, l, d - 1)
    else l
  }
  def isPrime(n: Int) = {
    val d = n
    val q = f(n, List(), d)
    if (q.length == 2) true

    else false
  }
  val d3 = isPrime(17).toString
  def apply() :Route = pathPrefix(Remaining){name:String =>
    complete(nameSurnameJSON("Ann", "Sivokhina", "task3", d3))
  }
}
```
