import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_cubit.dart';
import 'package:task/modules/post/cubit/posts_state.dart';
import 'package:task/views/pots_scressn/widgets/post_builder.dart';
import 'package:task/views/pots_scressn/widgets/post_screen_top_bar.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 30) {
      if (context.read<PostCubit>().state is PostLoadingMoreData) {
        return;
      }
      context.read<PostCubit>().fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          const SliverToBoxAdapter(child: PostScreenTopBar()),
          const PostsBuilder(),
          BlocConsumer<PostCubit, PostState>(
              builder: (context, state) {
                return state is PostLoadingMoreData
                    ? SliverToBoxAdapter(
                        child: Transform.translate(
                          offset: const Offset(0, -20),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter();
              },
              listener: (context, state) {})
        ],
      ),
    );
  }
}
