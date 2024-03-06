import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/src/post/post_model.dart';

class PostApiProvider {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<PostModel>> fetchPostsFromApi(int startIndex, int limit) async {
    final response = await http
        .get(Uri.parse('$baseUrl/posts?_start=$startIndex&_limit=$limit'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<PostModel> posts =
          body.map((dynamic item) => PostModel.fromJson(item)).toList();
      return posts;
    } else {
      throw "Failed to load posts";
    }
  }

  Future<List<PostModel>> fetchPostsFromHiveStorage(
      int startIndex, int limit) async {
    return [];
  }
}
