import 'dart:io';
import 'dart:convert' show json;

main() async {
  dartHandler(HttpRequest request) {
    var result = {
      'count': 2,
      'data': [
        {'name': 'BGA', 'age': 27},
        {'name': 'bingoogolapple', 'age': 27}
      ]
    };
    request.response.headers.contentType = new ContentType('application', 'json');
    request.response.write(json.encode(result));
    request.response.close();
  }

  var requests = await HttpServer.bind('127.0.0.1', 8888);
  await for (var request in requests) {
    print('Got request for ${request.uri.path}');
    if (request.uri.path == '/bga') {
      dartHandler(request);
    } else {
      request.response.write('Not found');
      request.response.close();
    }
  }
}

class Bean {
  String name;
  int age;

  Bean(this.name, this.age);
}
