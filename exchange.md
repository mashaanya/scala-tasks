```scala
import akka.http.scaladsl.server.util.Tuple

object exchannge extends App{
  def indexf(i: (String,String,String,Int,Int), L: List[(String,String,String,Int,Int)], index: Int): Int = L match {
    case a :: Nil => index
    case a :: tail if i == a => index
    case a :: tail => indexf(i, tail, index + 1)
    case _ => throw new Exception

  }
  def sort(apl:List[(String,String,String,Int,Int)],output:List[(String,String,String,Int,Int)],dummy:(String,String,String,Int,Int)):List[(String,String,String,Int,Int)] = apl match{
    case i::Nil => output
    case i::tail if couple(i,apl,dummy)!= dummy =>
      val o = output ::: List(i, couple(i,apl,dummy))
      val index = indexf(couple(i,apl,dummy),apl,0)
      val apl1 = tail.take(index) ++ tail.drop(index+1)
      sort(apl1,o,dummy)
    case i::tail => sort(tail,output,dummy)
    case _ => throw new Exception
  }
  def couple(i:(String,String,String,Int,Int), tail:List[(String,String,String,Int,Int)], dummy:(String,String,String,Int,Int)):(String,String,String,Int,Int) = tail match{
    case a::Nil if (a._2 != i._2) && (a._3 == i._3) && (a._4 == i._4) && (a._5 == i._5) => a
    case a::Nil => dummy
    case a::tail if (a._1 !=i._1) && (a._2 != i._2) && (a._3 == i._3) && (a._4 == i._4) && (a._5 == i._5) => a
    case a::tail => couple(i,tail,dummy)
    case _ => throw new Exception

  }
  def action(wal:List[(String, Int,Int,Int,Int,Int)], coup:List[(String,String,String,Int,Int)],newwal:List[(String, Int,Int,Int,Int,Int)]):List[(String, Int,Int,Int,Int,Int)]= wal match{
    case i::Nil => newwal :+ search(i,coup)
    case i::tail =>

      action(tail,coup, newwal:+search(i,coup))
    case _ => throw new Exception
  }
  def search(i:(String, Int,Int,Int,Int,Int),coup:List[(String,String,String,Int,Int)]):(String, Int,Int,Int,Int,Int)= coup match{
    case a::Nil if a._1 == i._1 => change(i,a)
    case a::Nil => i
    case a::tail if a._1 == i._1 => change(i,a)
    case a::tail => search(i,tail)
    case _ => throw new Exception
  }
  def change(i:(String, Int,Int,Int,Int,Int),a:(String,String,String,Int,Int)):(String, Int,Int,Int,Int,Int) = {
    val buy = a._2
    val currency = a._3
    if (buy == "s") {
      if (currency == "A") {
        val r1 = i._2 + a._4 * a._5
        val r2 = i._3 - a._5
        if (r2 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, r2, i._4, i._5, i._6)
          newi
        }
      }

      else if (currency == "B") {
        val r1 = i._2 + a._4 * a._5
        val r2 = i._4 - a._5
        if (r2 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, i._3, r2, i._5, i._6)
          newi
        }
      }
      else if (currency == "C") {
        val r1 = i._2 + a._4 * a._5
        val r2 = i._5 - a._5
        if (r2 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, i._3, i._4, r2, i._6)
          newi
        }
      }
      else  {
        val r1 = i._2 + a._4 * a._5
        val r2 = i._6 - a._5
        if (r2 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, i._3, i._4, i._5, r2)
          newi
        }
      }
    }
    else {
      if (currency == "A") {
        val r1 = i._2 - a._4 * a._5
        val r2 = i._3 + a._5
        if (r1 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, r2, i._4, i._5, i._6)
          newi
        }
      }
      else if (currency == "B") {
        val r1 = i._2 - a._4 * a._5
        val r2 = i._4 + a._5
        if (r1 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, i._3, r2, i._5, i._6)
          newi
        }
      }
      else if (currency == "C") {
        val r1 = i._2 - a._4 * a._5
        val r2 = i._5 + a._5
        val newi = (i._1, r1, i._3, i._4, r2, i._6)
        newi
      }
      else  {
        val r1 = i._2 - a._4 * a._5
        val r2 = i._6 + a._5
        if (r1 < 0) {
          val newi = (i._1, i._2, i._3, i._4, i._5, i._6)
          newi
        }
        else {
          val newi = (i._1, r1, i._3, i._4, i._5, r2)
          newi
        }
      }
    }

  }

  final val dummy = ("", "", "" ,5 ,15)
  val wallet = List(("C1", 1000, 10 ,5 ,15, 0),
    ("C2", 1500 ,0, 0, 0, 0),
    ("C3", 1200, 10, 5, 20, 0),
    ("C4", 1700, 10, 5, 0, 0),
    ("C5", 1300, 10, 5, 0, 0),
    ("C6", 1000000, 10, 5, 10, 0),
    ("C7", 0 ,10, 5, 12, 0),
    ("C8", 0, 10, 5, 45, 0))
  val application = List(("C1", "b", "A", 7, 12),
    ("C2", "s", "C", 1, 1),
    ("C7", "b", "A", 7, 12),
    ("C8", "b", "A", 7, 12),
    ("C7", "b", "A", 7, 12),
    ("C3", "b", "C", 1, 1),
    ("C4", "s", "A", 7, 12))
  val coup = sort(application,List(),dummy)
  print(action(wallet,coup,List()))
```
