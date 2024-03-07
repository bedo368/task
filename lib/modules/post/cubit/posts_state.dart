import 'package:flutter/material.dart';
import 'package:task/modules/post/post_model.dart';

// Abstract base class representing the state of the post-related operations
@immutable
abstract class PostState {}

// Initial state indicating that no operation related to posts has been initiated
class PostInitialState extends PostState {}

// State indicating that post-related data is being loaded or fetched
class PostLoading extends PostState {}

// State indicating that post-related data has been successfully loaded or fetched
class PostLoadedState extends PostState {
  final List<PostModel> posts; // List of posts loaded or fetched successfully

  PostLoadedState({required this.posts});
}

class PostLoadingMoreData extends PostState {
  final List<PostModel> posts; // List of posts loaded or fetched successfully

  PostLoadingMoreData({required this.posts});
}

// State indicating that an error occurred while loading or fetching post-related data
class PostError extends PostState {
  final String message; // Error message describing the cause of the error
  final List<PostModel> posts; // the current posts

  PostError({
    required this.message,
    required this.posts,
  });
}
