import 'package:task/modules/post/post_model.dart';
import 'package:task/modules/post/post_provider.dart';
import 'package:task/utils/check_internt_conection.dart';

class PostRepository {
  final _postProvider =
      PostApiProvider(); // Instance of PostApiProvider for fetching posts

  // Fetches posts either from API or local storage based on internet connection
  Future<List<PostModel>> fetchPosts(int startIndex, int limit) async {
    try {
      bool connectionState =
          await checkInternetConnection(); // Check internet connection
      if (connectionState) {
        // If there's internet connection, fetch posts from API
        return _postProvider.fetchPostsFromApi(startIndex, limit);
      }
      if (!connectionState && startIndex > 0) {
        throw "there is no connction please try again later";
      }
      if (!connectionState && startIndex == 0) {
        // If no internet connection, fetch posts from local storage (Hive)
        return _postProvider.fetchPostsFromHiveStorage(startIndex);
      }
      return [];
    } catch (e) {
      // Handle any errors that occur during fetching
      throw "Failed to load posts there is no connction please try again later";
    }
  }
}
