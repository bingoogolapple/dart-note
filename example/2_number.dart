main() {
  // 数值类型：int 和 double 都继承自 num
  num a = 1;
  print(a);
  a = 3.14;
  print(a);

  int b = 1;
  // double 类型的值不能赋值给 int 类型的变量 Error: A value of type 'dart.core::double' can't be assigned to a variable of type 'dart.core::int'
//  b = 3.14;
  double c = 3.14;
  print(c.runtimeType); // double
  // int 类型的值可以赋值给 double 类型的变量
  c = 1;
  print(c.runtimeType); // double

  print(1 + 3.14); // 4.140000000000001

  double d = 6.28;
  int e = 2;
  print(d + e); // 加 8.280000000000001
  print(d - e); // 减 4.28
  print(d * e); // 乘 12.56
  print(d / e); // 除 3.14
  print(d ~/ e); // 取整 3
  print(d % e); // 取余 0.28000000000000025

  print(0.0/0.0); // 非数字 NaN

  print(1.isOdd); // 奇数 true
  print(1.isEven); // 偶数 false
  print(2.isOdd); // 奇数 false
  print(2.isEven); // 偶数 true

  print((-100).abs()); // 取绝对值 100
  print(1.4.round()); // 四舍五入 1
  print(1.5.round()); // 四舍五入 2
  print(1.5.floor()); // 取小于它的最大整数 1
  print(1.5.ceil()); // 取大于它的最小整数 2
  print(1.5.toInt());
  print(1.toDouble());
}