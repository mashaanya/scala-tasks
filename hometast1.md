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
    i match {
      case a :: Nil => l
      case a :: tail => if (x.contains(a.last) && y.contains(tail.head)) g(tail, x, y, l :+ "1") else if (y.contains(a.last) && x.contains(tail.last)) g(tail,x,y,l:+"1") else g(tail, x, y, l)
      case _ => throw new Exception
    }
  }

  val a = List("a","a","b","b","e")
  val x = List("a","e","o","u","y")
  val y = List("b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z")
  val i = f1(a,List())
  val w=g(i,x,y,List())
  print(w.length)
  ```
  task 3
  ```scala 
  ```
  
