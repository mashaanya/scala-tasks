к-тый элемент через рекурсию
```scala
def f(i: List[Int], k:Int):Int = i match{
    case a::tail => if (k>0) f(tail,k-1) else a
    case _ => throw new Exception

  }
  val a = List(1,2,3,4)
  val k = 3
  print(f(a,k))
```
перевернуть список рекурсия
```scala
def f(i: List[Int], k:Int):Int = i match{
    case a::tail => if (k>0) f(tail,k-1) else a
    case _ => throw new Exception

  }
  def f(i: List[Int], k: List[Int],l:Int):List[Int] = if (l>0) f(i,k:+f(i,l-1),l-1) else (k)




  val a = List(1,2,3,4)
  val k = Nil
  val l = a.length
  print(f(a,k,l))
```
палиндром
``` scala
val p = a.reverse
  if (p==a) print(True) else print(False)
```
палиндром рекурсия
``` scala
 def f(i: List[Int], k:Int):Int = i match{
    case a::tail => if (k>0) f(tail,k-1) else a
    case _ => throw new Exception
  }
  def f(i: List[Int], k: List[Int],l:Int):List[Int] = if (l>0) f(i,k:+f(i,l-1),l-1) else (k)




  val a = List(1,2,2,1)
  val k = Nil
  val l = a.length
  val p = f(a,k,l)
  if (p==a) print(True) else print(False)
```
