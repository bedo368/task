import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_cubit.dart';
import 'package:task/modules/post/cubit/posts_state.dart';
import 'package:task/views/pots_scressn/widgets/post_card.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      if (state is PostInitialState) {
        context.read<PostCubit>().fetchPosts();

        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      }
      if (state is PostLoadedState) {
        return SliverList.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostCard(
                post: post,
              );
            });
      }
      if (state is PostLoadingMoreData) {
        return SliverList.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostCard(
                post: post,
              );
            });
      }

      if (state is PostError) {
        print(state);
        if (state.posts.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<PostCubit>().fetchPosts();
                      },
                      child: const Text("reload")),
                ],
              ),
            ),
          );
        }
        return SliverList.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostCard(
                post: post,
              );
            });
      }
      return SliverToBoxAdapter(child: Container());
    });
  }
}
