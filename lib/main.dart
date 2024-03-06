import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/post/cubit/posts_cubit.dart';
import 'package:task/modules/post/post_repositry.dart';
import 'package:task/utils/hive_service.dart';
import 'package:task/views/pots_scressn/posts_screen.dart';

void main() async {
  final HiveService hs = HiveService();
  await hs.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostCubit(PostRepository()),
        child: const PostsScreen(),
      ),
    );
  }
}
