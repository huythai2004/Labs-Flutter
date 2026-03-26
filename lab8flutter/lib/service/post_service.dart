import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab8flutter/model/post.dart';

class PostService {
    static const String url =
        "https://jsonplaceholder.typicode.com/posts";

    Future<List<Post>> fetchPost() async {

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "User-Agent": "Mozilla/5.0",
          "Accept": "application/json",
        },
      );

      print("STATUS CODE: ${response.statusCode}");

      if (response.statusCode == 200) {

        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData
            .map((item) => Post.fromJson(item))
            .toList();

      } else {
        throw Exception("Failed to loading Post - ${response.statusCode}");
      }
    }
}