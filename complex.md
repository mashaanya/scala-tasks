```scala
class Complex(val q:Int, w:Int){
  val a=q
  val b=w
  val i='i'

  override def toString()= a + "+" + s"${b}i"
  def +(that: Complex) = new Complex (
    a + that.a, b+that.b
  )
  def *(that: Complex) = new Complex(
    a*that.a - b*that.b, b*that.a + a*that.b
  )
  def -(that: Complex)= new Complex(
    a-that.a, b-that.b
  )
  def /(that: Complex) = new Complex(
    a/that.a+b/that.b, a/that.b+b/that.a
  )
  def this (n:Int) = this(n,0)
}
object Main extends App {
implicit def intoRational(n:Int) = new Rational(n)
val a = new Complex(2,3)
  val b = new Complex(1,3)
  print(a/b)

```
