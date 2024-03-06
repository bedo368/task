import 'package:task/src/post/post_model.dart';
import 'package:task/src/post/post_provider.dart';
import 'package:task/utils/check_internt_conection.dart';

class PostRepository {
  final _postApiProvider = PostApiProvider();

  Future<List<PostModel>> fetchPosts(int startIndex, int limit) async {
    try {
      bool connectionState = await checkInternetConnection();
      if (connectionState) {
        return _postApiProvider.fetchPostsFromApi(startIndex, limit);
      } else {
        _postApiProvider.fetchPostsFromHiveStorage(startIndex, limit);
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
