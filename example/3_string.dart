main() {
  test1();
  test2();
}

test1() {
  // 使用单引号或双引号创建字符串，都支持插值表达式
  String a = 'Hello';
  String b = "World";
  String c = 'sd${1 + 1}s\ndf${b}fsd$a';
  print(c);
  String d = "sdsdfsdfsdf\nsd${1 + 1}sdf${a}sdf";
  print(d);
  print('---------------------------------------------');
  // 没有分号标识语句结束时，可以不用加号链接字符串
  String e = 'sd${1 + 1}s\nd'
      'f${b}fsd$a';
  print(e);
  String f = "sdsdfs"
      "dfsdf\nsd${1 + 1}sdf${a}sdf";
  print(f);

  // 三个双引号或三个单引号原样输出，都支持插值表达式
  String g = """第一${a}行$b
第$a二行$b
第\n三行
"""; // 最后这里有换行
  print(g);
  String h = '''第一${a}行$b
第$a二行$b
第\n三行
''';
  print(h);

  // 使用 r 创建原始字符串，会忽略转移字符
  String i = r"第一行\n第二行";
  print(i);
  String j = r'第一行\n第二行';
  print(j);

  String k = 'BGA';
  print(k + 'bingo');
  print(k * 3);
  // 判断内容是否相等
  print(k == "BGA");
  print(k[0]);

  String l = 'bingoogolapple';
  print(l.length);
  print(l.isEmpty);
  print(l.isNotEmpty);
  print(l.startsWith('bingo'));
  print(l.startsWith('googol'));
  print(l.startsWith('apple'));
  print(l.replaceAll('g', 'G'));
  print(l.toUpperCase());
  print(l.indexOf('googol'));
  print(l.substring(3, 9));

  // 填充到指定长度，第二个参数为要填充的值，默认填充空格
  print('1111'.padLeft(8, '2')); // 22221111
  print('1111'.padRight(8, '2')); // 11112222

  // 从左边第一个字符开始比较，如果前面的字符都相等则比较长度
  print('2'.compareTo('3')); // -1
  print('2'.compareTo('2')); // 0
  print('22'.compareTo('2')); // 1
}

/**
 * Unicode 为每一个字符、标点符号、表情符号等都定义了 一个唯一的数值。
 * 由于 Dart 字符串是 UTF-16 code units 字符序列，所以在字符串中表达 32-bit Unicode 值就需要新的语法了
 */
test2() {
  var a = '\u{1f44f}';
  print(a);
  print(a.codeUnits);
  print(a.runes.toList());

  Runes b = Runes('\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(String.fromCharCodes(b));

  // 字符串反转
  var c = "BGA \u{1f605} bingoogolapple"; // BGA 😅 bingoogolapple
  print(c);
  print(String.fromCharCodes(c.runes.toList().reversed)); // 正确 elppalogoognib 😅 AGB
  print(c.split('').reversed.join()); // 会出现乱码 elppalogoognib �� AGB


}
