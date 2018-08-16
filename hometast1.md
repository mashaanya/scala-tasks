task 1
```scala
object Main extends App {
  def pack[A](ls: List[A]): List[List[A]] = {
    if (ls.isEmpty) List(List())
    else {
      val (packed, next) = ls span {
        _ == ls.head
      }
      if (next == Nil) List(packed)
      else packed :: pack(next)
    }
  }

  def f(q: List[List[Int]], l: List[Int]): List[Int] = q match {
    case a :: Nil => l :+ a.length
    case a :: tail => f(tail, l :+ a.length)
    case _ => throw new Exception
  }
  def f1(q:List[List[Int]],w:List[Int]):List[Int] = q match{
    case a::Nil=> w:+a.head
    case a::tail=> f1(tail,w:+a.head)
    case _ => throw new Exception
  }

  def RLE(a:List[Int]) ={
    val q=pack(a)
    val l=f(q,List())
    val e=f1(q,List())
    l.zip(e)

  }

  val a = List(1,-1,1,-1)
  println(RLE(a).length-1)
  ```
  task 2 (не понимаю почему она не выходит из рекурсии)
  ```scala
  object Main extends App {

    def f1(q:List[String],w:List[String]):List[String] = q match{
      case a::Nil=> w:+a
      case a::tail=> f1(tail,w:+a)
      case _ => throw new Exception
    }


    def g(f:List[String],x:List[String],y:List[String],l:List[String]):List[String] = {
      f match {
        case a :: Nil => l
        case a :: tail if (x.contains(a) && y.contains(tail.head)) =>  g(tail, x, y, l :+ "1")
        case a :: tail if (y.contains(a) && x.contains(tail.head)) => g(tail,x,y,l:+"1")
        case a :: tail => g(tail, x, y, l)
        case _ => throw new Exception
      }
    }

    val a = List("a","a","b","b","e")
    val x = List("a","e","o","u","y")
    val y = List("b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z")
    val i = f1(a,List())
    val w=g(i,x,y,List())
    print(w.length)
}
  ```
  task 3
  ```scala 
  object Main extends App {
  def f(a: Int, l: List[Int], d: Int): List[Int] = {
    if (d > 0 && a % d == 0) f(a, l :+ d, d - 1)
    else if (d > 0 && a % d != 0) f(a, l, d - 1)
    else l

  }

  //  def nthGreatestDivisior(a:Int,n:Int) = {
  //    val d=a
  //    val l=f(a,List(),d)
  //    val p= l.reverse
  //    val w = p.take(n)
  //    print(w.last)
  def isPrime(a: Int) = {
    val d = a
    val r = f(a, List(), d)
    if (r.length == 2) true
    else false
  }

  def ty(l: List[Int], e: List[Int]): List[Int] = l match {
    case a :: Nil => if (isPrime(a)) e :+ a else e
    case a :: tail => if (isPrime(a)) ty(tail, e :+ a) else ty(tail, e)
    case _ => throw new Exception
  }

  def iu(x: Int) = {
    val a = x
    val l = f(x, List(), a)
    val r = ty(l, List())
    r.head == 2
  }


  def binaryDivisiors(k: List[Int], l: List[Int]): List[Int] = {
    print(l)

    k match {
      case a :: Nil if iu(a) =>  l:+a
      case a :: tail if iu(a) => binaryDivisiors(tail, l :+ a)
      case b :: tail  => binaryDivisiors(tail, l)
      case _ => throw new Exception
    }
  }

  val a = 24
  val d = a
  val k = f(a, List(), d)
  print((binaryDivisiors( k, List())).reverse)
}
```

  
