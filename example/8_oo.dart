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
}

class Point {
  final int x;
  final int y;
  final double distance;

//  Point(x, y)
//      : x = x,
//        y = y,
//        distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  // 上面的简化写法
//  Point(this.x, this.y) : distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  Point(this.x, this.y) : distance = sqrt(x * x + y * y);

  // 命名构造函数：构造函数的函数名后加「.自己的名字」
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

  Point operator +(Point other) {
    return new Point(this.x + other.x, this.y + other.y);
  }

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
 * 如果你的类提供一个状态不变的对象，你可以把这些对象定义为编译时常量。
 * 需要定义一个 const 构造函数，并且声明所有类的变量为 final
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

  num get right => left + width;

  set right(num value) => left = value - width;

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
