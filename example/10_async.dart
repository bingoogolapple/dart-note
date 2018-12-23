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
