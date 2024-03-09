import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/modules/post/post_model.dart';
import 'package:task/utils/check_internt_conection.dart';
import 'package:task/utils/hive_service.dart';

class PostProvider {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final _hiveProvider =
      HiveService(); // Instance of HiveService for local storage

  // Fetch posts from API
  Future<List<PostModel>> fetchPostsFromApi(int startIndex, int limit) async {
    try {
      // Make HTTP GET request to the API
      final response = await http
          .get(Uri.parse('$baseUrl/posts?_start=$startIndex&_limit=$limit'));

      // Check if response is successful
      if (response.statusCode == 200) {
        // Parse response body into a list of dynamic objects
        List<dynamic> body = json.decode(response.body);

        // Map dynamic objects to PostModel objects using PostModel.fromJson constructor
        List<PostModel> posts =
            body.map((dynamic item) => PostModel.fromJson(item)).toList();

        // Add fetched posts to local storage (Hive)

        if (await checkInternetConnection()) {
          await _hiveProvider.addMorePost(posts: posts, startIdex: startIndex);
        }

        // Return the list of fetched posts
        return posts;
      }
    } catch (e) {
      // Throw an error if fetching posts from API fails
      throw "Failed to load posts";
    }

    // Return an empty list if fetching posts from API fails
    return [];
  }

  // Fetch posts from local storage (Hive)
  Future<List<PostModel>> fetchPostsFromHiveStorage(int startIndex) async {
    try {
      // Retrieve posts from local storage using HiveService
      return await _hiveProvider.getPostsFrom();
    } catch (e) {
      // Throw an error if fetching posts from local storage fails
      throw "Failed to load posts";
    }
  }
}
