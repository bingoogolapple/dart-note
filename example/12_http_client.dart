import 'dart:io';
import 'dart:convert';

main() async {
  var url = Uri.parse('http://127.0.0.1:8888/bga');
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(url);
  print('have request');
  var response = await request.close();
  print('have response');
  var data = await utf8.decoder.bind(response).toList();
  var body = data.join('');
  print(body);
  httpClient.close();
}
