import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/post/cubit/posts_state.dart';
import 'package:task/src/post/post_model.dart';
import 'package:task/src/post/post_repositry.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  final List<PostModel> _posts = [];
  int _startIndex = 0;
  final int _limit = 10;
  bool loadingMoreDate = false;

  PostCubit(this._postRepository) : super(PostInitialState());

  void fetchPosts() async {
    try {
      loadingMoreDate = true;
      final posts = await _postRepository.fetchPosts(_startIndex, _limit);
      loadingMoreDate = false;
      _posts.addAll(posts);
      _startIndex += _limit;
      emit(PostLoadedState(posts: _posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
