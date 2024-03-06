import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_state.dart';
import 'package:task/modules/post/post_model.dart';
import 'package:task/modules/post/post_repositry.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository; // Repository for fetching posts
  final List<PostModel> _posts = []; // List to hold fetched posts
  int _startIndex = 0; // Index to start fetching posts from
  final int _limit = 10; // Limit of posts to fetch per request
  bool loadingMoreDate =
      false; // Flag indicating whether more data is being loaded

  // Constructor for initializing the cubit with a PostRepository instance
  PostCubit(this._postRepository) : super(PostInitialState());

  // Method to fetch posts from the repository
  void fetchPosts() async {
    try {
      loadingMoreDate = true; // Set loading flag to true
      final posts =
          await _postRepository.fetchPosts(_startIndex, _limit); // Fetch posts
      loadingMoreDate = false; // Set loading flag to false
      _posts.addAll(posts); // Add fetched posts to the list
      _startIndex += _limit; // Increment start index for the next fetch
      emit(PostLoadedState(
          posts: _posts)); // Emit a PostLoadedState with the fetched posts
    } catch (e) {
      // Handle errors by emitting a PostError state with the error message
      emit(PostError(message: e.toString()));
    }
  }
}
