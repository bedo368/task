import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_cubit.dart';
import 'package:task/modules/post/cubit/posts_state.dart';

class ShowSnakbarError extends StatelessWidget {
  const ShowSnakbarError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          state.message,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            context.read<PostCubit>().fetchPosts();
                          },
                          child: const Text("reload")),
                    ],
                  ),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Container(),
      ),
    );
  }
}