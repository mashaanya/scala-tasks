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


  def f(a: Int, n: Int, l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, n, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, n, l, d - 1)
    else l

  }
  def nthGreatestDivisior(a:Int,n:Int) = {
    val d=a
    val l=f(a,n,List(),d)
    val p= l.reverse
    val w = p.take(n)
    print(w.last)
  }

  val a = 12
  val n = 3
 nthGreatestDivisior(a,n)
```
task 4
```scala
object Main extends App {


  def f(a: Int,  l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, l, d - 1)
    else l
  }
  def numOfDivisiors(n:Int) = {
    val d=n
    val q=f(n,List(),d)
    q.length
  }
  def sumOfDivisiors(n:Int) = {
    val d=n
    val q=f(n,List(),d)
    q.foldLeft(0){(acc,i)=> acc + i }
  }

  val n = 12
  println(numOfDivisiors(n))
  println(sumOfDivisiors(n))
}
```
task 5
```scala
object Main extends App {
  //implicit def intoRational(n:Int) = new Rational(n)
  //val a = new Complex(2,3)
  //  val b = new Complex(1,3)
  //  print(a/b)


  def f(a: Int,  l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, l, d - 1)
    else l
  }
 def isPrime(n:Int) = {
   val d=n
   val q=f(n,List(),d)
   if (q.length == 2) True
   else False

 }
  val n=15
  print(isPrime(n))
}
```
