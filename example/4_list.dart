main() {
  var a = [1, 4, 3, 1, 5, 2];
  print(a);
  print(a.length);
  a.add(6);
  print(a);
  a.remove(1);
  print(a);
  a.removeAt(2);
  print(a);
  a.sort(); // 默认是升序
  print(a);
  print(a.runtimeType); // List<int>

  // 加上 const 创建不可变 List
  var b = const [1, 5, "BGA", 3, true, 2, 4];
  print(b.runtimeType); // List<Object>
  // Unsupported operation: Cannot add to an unmodifiable list
//  b.add(6);
  print(b);
  b.forEach(print);

  var c = List(); // []
  print(c);
  print(c.runtimeType); // List<dynamic>
  var d = List(5); // [null, null, null, null, null]
  print(d);
  print(d.runtimeType); // List<dynamic>
  var e = List<dynamic>();
  e.add(true);
  e.add("BGA");
  e.add(3);
  print(e.runtimeType);

  var f = List<Object>();
  f.add(true);
  f.add("BGA");
  f.add(3);
  print(f.runtimeType); // List<Object>
}
