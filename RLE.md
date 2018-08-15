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

  def f(q: List[List[String]], l: List[Int]): List[Int] = q match {
    case a :: Nil => l :+ a.length
    case a :: tail => f(tail, l :+ a.length)
    case _ => throw new Exception
  }
  def f1(q:List[List[String]],w:List[String]):List[String] = q match{
    case a::Nil=> w:+a.head
    case a::tail=> f1(tail,w:+a.head)
    case _ => throw new Exception
  }

    def RLE(a:List[String]) ={
    val q=pack(a)
    val l=f(q,List())
    val e=f1(q,List())
    l.zip(e)

    }

  val a = List("a", "a", "b", "c", "c")
  println(RLE(a))
}
```
