import 'dart:async';

main() {
  test1();
  test2();
  test3();
  print('main');
}

Future<String> demo1() {
//  return Future<String>(() {
//    return "demo1";
//  });

  return Future<String>.delayed(Duration(milliseconds: 2000), () {
    return 'demo1';
  });
}

test1() {
  demo1().then((value) {
    print(value);
  }).catchError((error) {
    print('test1 catchError');
  });
  print('test1');
}

Future<String> demo2() {
  return Future<String>.delayed(Duration(milliseconds: 2000), () {
    throw Exception('demo2 Exception');
  });
}

test2() {
  demo2().then((value) {
    print(value);
  }).catchError((error) {
    print('test2 catchError $error');
  });
  print('test2');
}

Future<String> demo3() {
  return Future<String>.delayed(Duration(milliseconds: 2000), () {
    return 'demo3';
  });
}

test3() async {
  try {
    String result = await demo3();
    print(result);
  } catch (e) {
    print('test3 catchError $e');
  }
  print('test3');
}

testException() {
  try {
    // 可能引发异常的代码
  } on IntegerDivisionByZeroException {
    print('IntegerDivisionByZeroException');

    // 可以重新抛出，错误堆栈信息为原始错误位置
    rethrow;
  } on FormatException catch (e1) {
    print(e1);
    // 抛出异常，错误堆栈信息为当前位置
    throw e1;
  } catch (e2) {
    // 捕获所有异常
    print(e2);
    // 可以重新抛出，错误堆栈信息为原始错误位置
    rethrow;
  } finally {
    print('在 try、on、catch 之后无条件执行可选的 finally 块');
  }
}
