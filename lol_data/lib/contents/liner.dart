
class Liner
{
  late double a;
  late double b;

  Liner(double x1 , double y1, double x2 , double y2){
    a = (y2 - y1)/(x2 - x1);
    b = -(y2 - y1)/(x2 - x1) * x1 + y1;
  }

  double getFunctionValue(double x){
    return a * x + b;
  }
}

