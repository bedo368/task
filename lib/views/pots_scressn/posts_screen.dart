import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_cubit.dart';
import 'package:task/modules/post/cubit/posts_state.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController sc = ScrollController();
    return Scaffold(
      body: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
        if (state is PostInitialState) {
          context.read<PostCubit>().fetchPosts();

          return const Center(child: CircularProgressIndicator());
        }
        if (state is PostLoadedState) {
          return ListView.builder(
              controller: sc,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return Text(state.posts[index].userId.toString());
              });
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostCubit>().fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
