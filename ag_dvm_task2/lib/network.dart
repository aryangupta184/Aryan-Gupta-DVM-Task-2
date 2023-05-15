import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './post.dart';

List<Post> parsePost(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((model) => Post.fromJson(model)).toList();
  return posts;

}

Future<List<Post>> fetchPost() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200){
    return compute(parsePost, response.body);
  }else {
    throw Exception("Request API Error");
  }
}
