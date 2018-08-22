Main
```scala
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
import Hey._
import Hi._
import nameRoute._

import scala.collection.mutable.ListBuffer


//import scala.concurrent.ExecutionContext.Implicits.global

object Main123 extends App {
  val List12: ListBuffer[(String, String, String, Int, Int)] = ListBuffer.empty
  val List123: ListBuffer[(String, Int, Int, Int, Int)] = ListBuffer.empty
  implicit val system = ActorSystem("my-system")
  implicit val materializer = ActorMaterializer()
  implicit val executionContext = system.dispatcher
  val wallet = List(("C1", 1000, 10 ,5 ,15, 0),
    ("C2", 1500 ,0, 0, 0, 0),
    ("C3", 1200, 10, 5, 20, 0),
    ("C4", 1700, 10, 5, 0, 0),
    ("C5", 1300, 10, 5, 0, 0),
    ("C6", 1000000, 10, 5, 10, 0),
    ("C7", 0 ,10, 5, 12, 0),
    ("C8", 0, 10, 5, 45, 0))
  val route = pathPrefix("application") {
        application(List12,wallet)
    }




  val bindingFuture = Http().bindAndHandle(route, "localhost", 8080)

  println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
  StdIn.readLine() // let it run until user presses return
  bindingFuture
    .flatMap(_.unbind()) // trigger unbinding from the port
    .onComplete(_ => system.terminate()) // and shutdown when done

}

```
application
```scala
import akka.actor.{ActorSystem, Props}
import akka.http.scaladsl.server.Directives.pathPrefix
import akka.http.scaladsl.server.Route
import akka.util.Timeout
import exchannge.{wallet, _}
import akka.http.scaladsl.server.Directives.{complete, pathPrefix}
import akka.http.scaladsl.server.PathMatchers.Remaining
import akka.http.scaladsl.server.util.Tuple

import scala.collection.mutable.ListBuffer


object application {
  val List12: ListBuffer[(String, String, String, Int, Int)] = ListBuffer.empty

def f(l:ListBuffer[(String,String,String,Int,Int)], i:(String,String,String,Int,Int)) = l+=i
  def apply(orders: ListBuffer[(String,String,String,Int,Int)],wallet:List[(String, Int,Int,Int,Int,Int)]): Route = pathPrefix(Remaining) { thing: String =>


    val newappl = thing.split("_")
    val newl: (String, String, String, Int, Int) = (newappl(0),newappl(1), newappl(2), newappl(3).toInt, newappl(4).toInt)
    val list = f(List12, newl)
    val dummy = ("", "", "", 5, 15)
    val newappl1 = couple(newl, list.toList,dummy)
    if (newappl1 != dummy) {
      val newappl2 = sort(list.toList, List(),dummy)
      list -= newl
      list-= newappl1
      complete(action(wallet,newappl2,List()).mkString)

    }
    else complete("")


  }
}
```
exchange in other file
