main() {
  // 弱类型定义方式：用 var 定义变量时可以动态类型转换，dynamic
  var a;
  // 未初始化时，默认值为 null
  print(a);
  a = 3;
  print(a);
  print(a.runtimeType); // int
  a = 'BGA';
  print(a);
  print(a.runtimeType); // String

  // 强类型定义方式：用具体类型定义变量时，同父类型可以转换，和 Java 一样
  num b = 1;
  print(b);
  b = 3.14;
  print(b);
  // Error: A value of type 'dart.core::String' can't be assigned to a variable of type 'dart.core::int'.
//  b = "BGA";

  // 使用 final 声明一个只能赋值一次的变量
  final c = 1;
  // Error: Setter not found: 'c'
//  c = 2;
  // 使用 const 声明编译期常量，在编译期就能确定它的值
  const d = 1;
  // Error: Setter not found: 'd'
//  d = 2;

  testDefaultValue();
}

// 所有的类型，声明后不赋值的话，默认都是 null
testDefaultValue() {
  var a;
  print(a);
  bool b;
  print(b);
  dynamic c;
  print(c);
  num d;
  print(d);
  int e;
  print(e);
  double f;
  print(f);
  String g;
  print(g);
}
