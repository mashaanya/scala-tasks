# 21
  def f(i:List[Int]) = i.init
  val a=List(1,2,3)
  val o=f(a)
  print(o.last)
  # 22
   def f(i: List[Int]):Int = i match {
    case a :: b :: Nil => a
    case  b :: tail => f(tail)
    case _ => throw new Exception
  }

  val a = List(1, 2, 3)
  print(f(a))
  #31
   def f(i:List[Int],k:Int) = i.take(k)
  val a = List(1,2,3,4,5)
  val k =3
  print(f(a,k).last)
  #32
  #41
   def f(i:List[Int]) = i.length
  val a = List(1,2,3,4)
  print(f(a))
  #42
   def f(i: List[Int], k: Int): Int = i match {
    case a :: Nil => k
    case a :: tail => f(tail, k + 1)
    case _ => throw new Exception

  }
  val a = List(1,2,3,4)
  print(f(a,0) + 1)
  #51
   def f1(i:List[Int]) = i.reverse
  val a = List(1,2,3)
  print(f1(a))
  #52
