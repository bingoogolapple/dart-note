import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  test4();
}

test4() {
  var url = 'http://localhost:8888/';
  // Client 类，保持持久连接，向同一个服务器发多个请求
  var client = new http.Client();
  client.get('${url}blogs').timeout(Duration(seconds: 3)).then((response) {
    print(response.body);
    return client.delete('${url}blogs/1');
  }).then((response) {
    print(response.body);
    return client.post('${url}blogs', body: json.encode({'title': '我是新增博客的标题', 'content': '我是新增博客的内容'}));
  }).then((response) {
    print(response.body);
    return client.put('${url}blogs/2', body: json.encode({'id': 2, 'title': '我是修改后博客的标题', 'content': '我是修改后博客的内容'}));
  }).then((response) {
    print(response.body);
    return client.get('${url}blogs/2');
  }).then((response) {
    print(response.body);
    return client.get('${url}blogs');
  }).then((response) {
    print(response.body);
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    // 完成后关闭 Client 连接
    client.close();
  });
}

test3() {
  var url = 'http://localhost:8888/blogs';
  http.post(url, body: json.encode({'title': '我是新增博客的标题', 'content': '我是新增博客的内容'})).then((response) {
    print("响应状态：${response.statusCode}");
    print("响应正文：${response.body}");
  });
}

test2() {
  var url = 'http://localhost:8888/blogs';
  http.get(url).then((response) {
    print("响应状态：${response.statusCode}");
    print("响应正文：${response.body}");
  });
}

test1() async {
  var url = Uri.parse('http://localhost:8888/blogs');
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(url);
  print('have request');
  var response = await request.close();
  print('have response');
  var body = await utf8.decoder.bind(response).first;
  print(body);
  httpClient.close();
}
