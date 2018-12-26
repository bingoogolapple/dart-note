import 'dart:math';

/**
 * Dart 没有表示访问权限的关键字，而是用符号名表示访问权限
 * 另外，Dart 中不存在针对类的访问权限，只有针对包（package）的
 * 凡以「_」（下划线）开头的符号（变量、类、函数等等）都是包内可见的，否则是包内外都可见的
 */
main() {
  // .. 语法为级联调用。使用级联调用语法可以在一个对象上执行多个操作
  var a = ChildPoint.test3(3, 4)
    ..getDistanceFromOrigin().toString()
    ..printX()
    ..printY();

  // as    is    is!
  print(a is Point);

  a
    ..getDistanceFromOrigin().toString()
    ..printX()
    ..printY();

  ImmutablePoint point1 = const ImmutablePoint(0, 0);
  ImmutablePoint point2 = const ImmutablePoint(0, 0);
  print('point1 == point2 is ${point1 == point2}');

  var logger = Logger('BGA');
  logger = Logger('BGA');
  logger.log('BGA');
  logger = Logger.test('bingoogolapple');
  logger = Logger.test('bingoogolapple');
  logger.log('bingoogolapple');

  var rect = new Rectangle(3, 4, 20, 15);
  print('before right is ${rect.right}');
  rect.right++;
  rect.right++;
  print('after right is ${rect.right}');

  testTypeDef();

  testSingleton();
  testDynamicAndObject();
}

// 和 Java 一样通过 class 关键字定义类
class Point {
  // 定义静态变量
  static int a = 1;

  // 定义属性
  int x;
  int y;
  double distance;

  // Dart 中每一个属性默认都有 getter 和 setter 方法，我们也可以自定义属性的 getter 和 setter
//  bool get isFar {
//    return distance > 1000;
//  }

  bool get isFart => distance > 100;

//  Point(x, y)
//      : x = x,
//        y = y,
//        distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  // 上面的简化写法。构造方法中支持「this.属性名」语法糖，传入参数时自动赋值，不用像 Java 那样挨个写 this.xxx = xxxx
//  Point(this.x, this.y) : distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  // 上面的简化写法
  Point(this.x, this.y) : distance = sqrt(x * x + y * y);

  // 命名构造方法：类名后加「.自己的名字」
  Point.named(this.x, this.y, this.distance);

  // 重定向构造方法
  Point.alongXAxis(x) : this(x, 0);

  Point.alongYAxis(y) : this.test1(0, y);

  Point.test1(x, y)
      : x = x,
        y = y,
        distance = sqrt(x * x + y * y);

  Point.test2(this.x, this.y) : distance = sqrt(x * x + y * y);

  Point.test3(this.x, this.y) : distance = sqrt(x * x + y * y) {
    print('Point.test3 x is $x, y is $y, distance is $distance');
  }

  double getDistanceFromOrigin() {
    print("getDistanceFromOrigin");
    return distance;
  }

  void printX() {
    print("printX");
  }

  void printY() {
    print("printY");
  }

  // 通过 operator 关键字重载操作符
  Point operator +(Point other) {
    return new Point(this.x + other.x, this.y + other.y);
  }

  // 定义静态方法
  static num distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class ChildPoint extends Point {
  ChildPoint.test3(x, y) : super.test3(x, y) {
    print('ChildPoint.test3 x is $x, y is $y, distance is $distance');
  }
}

/**
 * 如果你的类提供一个状态不变的对象，可以把这些对象定义为编译时常量。
 * 需要定义一个 const 构造方法，并且声明所有类的变量为 final。这在 Flutter 中用的比较多
 *
 * ImmutablePoint point1 = const ImmutablePoint(0, 0);
 * ImmutablePoint point2 = const ImmutablePoint(0, 0);
 * print('point1 == point2 is ${point1 == point2}');
 */
class ImmutablePoint {
  final num x;
  final num y;

  const ImmutablePoint(this.x, this.y);
}

class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  // 如果一个构造方法并不总是返回一个新的对象，则使用 factory 来定义这个构造方法
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      print('旧的$name');
      return _cache[name];
    } else {
      print('新创建$name');
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  // 如果一个构造方法并不总是返回一个新的对象，则使用 factory 来定义这个构造方法
  factory Logger.test(String name) {
    if (_cache.containsKey(name)) {
      print('test 旧的 $name');
      return _cache[name];
    } else {
      print('test 新创建 $name');
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}

class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Dart 中每一个属性默认都有 getter 和 setter 方法，我们也可以自定义属性的 getter 和 setter
  num get right => left + width;

  set right(num value) => left = value - width;

//  num get bottom {
//    return top + height;
//  }
  num get bottom => top + height;

  set bottom(num value) => top = value - height;
}

abstract class AbstractContainer {
  void updateChildren(); // Abstract method.
}

enum Color { red, green, blue }

testEnum() {
  // 枚举类型中的每个值都有一个 index getter 函数，该函数返回该值在枚举类型定义中的位置（从 0 开始）
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);
  // 枚举的 values 常量可以返回所有的枚举值
  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);
  // 如果在 switch (e) 中的 e 的类型为枚举类，如果没有处理所有该枚举类型的值的话，则会抛出一个警告
  Color aColor = Color.blue;
  switch (aColor) {
    case Color.red:
      print('Red as roses!');
      break;
    case Color.green:
      print('Green as grass!');
      break;
    default:
      print(aColor);
  }
}

typedef int Compare(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

int sort(Object a, Object b) => 0;

@todo('', '')
testTypeDef() {
  SortedCollection coll = new SortedCollection(sort);
  print(coll.compare is Function);
  print(coll.compare is Compare);
}

class todo {
  final String who;
  final String what;

  const todo(this.who, this.what);
}

class Person {
  // In the interface, but visible only in this library.
  final _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(who) => 'Hello, $who. I am $_name.';
}

// Dart 每个类都是接口
class Imposter implements Person {
  // We have to define this, but we don't use it.
  final _name = "";

  String greet(who) => 'Hi $who. Do you know who I am?';
}

testSingleton() {
  SingletonOne singletonOne1 = SingletonOne();
  SingletonOne singletonOne2 = SingletonOne.instance;

  SingletonOne singletonOne3 = SingletonOne._instance;
  SingletonOne singletonOne4 = SingletonOne._internal();
  print('singletonOne1 is ${singletonOne1.hashCode}');
  print('singletonOne2 is ${singletonOne2.hashCode}');
  print('singletonOne3 is ${singletonOne3.hashCode}');
  print('singletonOne4 is ${singletonOne4.hashCode}');

  SingletonTwo singletonTwo1 = new SingletonTwo();
  SingletonTwo singletonTwo2 = SingletonTwo.instance;

  SingletonTwo singletonTwo3 = SingletonTwo._instance;
  SingletonTwo singletonTwo4 = SingletonTwo._getInstance();
  SingletonTwo singletonTwo5 = SingletonTwo._internal();
  print('singletonTwo1 is ${singletonTwo1.hashCode}');
  print('singletonTwo2 is ${singletonTwo2.hashCode}');
  print('singletonTwo3 is ${singletonTwo3.hashCode}');
  print('singletonTwo4 is ${singletonTwo4.hashCode}');
  print('singletonTwo5 is ${singletonTwo5.hashCode}');
}

// 饿汉式
class SingletonOne {
  static final SingletonOne _instance = new SingletonOne._internal();

  static SingletonOne get instance => _instance;

  factory SingletonOne() {
    return _instance;
  }

//  SingletonOne._internal();
  SingletonOne._internal() {
    // 初始化
  }
}

// 懒汉式
class SingletonTwo {
  static SingletonTwo get instance => _getInstance();
  static SingletonTwo _instance;

  factory SingletonTwo() => _getInstance();

  SingletonTwo._internal() {
    // 初始化
  }

  static SingletonTwo _getInstance() {
    if (_instance == null) {
      _instance = new SingletonTwo._internal();
    }
    return _instance;
  }
}

testDynamicAndObject() {
  Object a = 'BGA';
  a = 27;
  a.toString(); // 只能调用 Object 支持的方法

  dynamic b = 'BGA';
  // 可以通过编译，但运行时会报错
//  b.sdf = 1; // NoSuchMethodError: Class 'String' has no instance setter 'sdf='.
//  b.sdfsdf(); // NoSuchMethodError: Class 'String' has no instance method 'sdfsdf'.
//  b[1] = 'b'; // NoSuchMethodError: Class 'String' has no instance method '[]='.

  // Dart 提供了关键字 is 进行类型检测
  if (a is int) {
    // 通过类型检测后 Dart 知道 a 为 int 类型，所以这里不需要强制类型转换
    a.toDouble();
  }
  if (b is String) {
    b.toLowerCase();
  }

  // Dart 也提供了 as 让我们进行类型的强制转换，但为了安全的转换，更推荐使用 is
  (a as int).toDouble();
  (b as String).toLowerCase();
}
