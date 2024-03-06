import 'package:flutter/material.dart';
import 'package:task/src/post/post_model.dart';

@immutable
abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoading extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;

  PostLoadedState({required this.posts});
}

class PostError extends PostState {
  final String message;

  PostError({required this.message});
}
