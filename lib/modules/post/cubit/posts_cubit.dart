import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_state.dart';
import 'package:task/modules/post/post_model.dart';
import 'package:task/modules/post/post_repositry.dart';
import 'package:task/utils/check_internt_conection.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  final List<PostModel> _posts = [];
  int _startIndex = 0;
  final int _limit = 10;

  PostCubit(this._postRepository) : super(PostInitialState());

  void fetchPosts() async {
    try {
      if (_startIndex > 0) {
        emit(PostLoadingMoreData(posts: _posts));
      }
      final posts =
          await _postRepository.fetchPosts(_startIndex, _limit); // Fetch posts
      _posts.addAll(posts);

      emit(PostLoadedState(posts: _posts));
      if (await checkInternetConnection() || posts.isNotEmpty) {
        _startIndex += posts.length;
      }
    } catch (e) {
      // Handle errors by emitting a PostError state with the error message
      emit(PostError(message: e.toString(), posts: _posts));
    }
  }
}
