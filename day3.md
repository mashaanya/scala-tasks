task1
```scala

import Math.sqrt
object Main extends App {
def isOdd(i:Int) = if (a%2==0) println(True) else println(False)

  def isEven(i:Int) = if (a%2!=0) println(True) else println(False)
  def isSquared(i:Int)= if (sqrt(i)%1 == 0) print(True) else print(False)

val a = 25
isOdd(a)
isEven(a)
  isSquared(a)
}
```
task 2
```scala
object Main extends App {

  def sumOfDigits(a:Int,s:Int):Int = {
  if (a>10) sumOfDigits(a/10,s+(a%10)) else (s+a)
}
  def compositionOfDigits(a:Int,c:Int):Int= {
    if (a>10) compositionOfDigits(a/10,c*(a%10)) else(c*a)
  }


val a = 25
  val b = 15
  val s = 0
  val c=1
println(sumOfDigits(a,s))
  println((compositionOfDigits(b,c)))
```
task 3
```scala
object Main extends App {


  def nthGreatestDivisior(a: Int, n: Int, l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) nthGreatestDivisior(a, n, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) nthGreatestDivisior(a, n, l, d - 1)
    else l

  }

  val a = 12
  val n = 3
  val d = a
  val l = List()
  val q = nthGreatestDivisior(a, n, l, d)
  val p= q.reverse
  val w = p.take(n)
  print(w.last)
}
```
