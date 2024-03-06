import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/modules/post/post_model.dart';
import 'package:task/utils/check_internt_conection.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  late Box<PostModel> _postBox; // Box to store PostModel objects

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  // Initialize Hive and open the box for PostModel
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
    try {
      _postBox = await Hive.openBox<PostModel>('posts');
    } catch (e) {
      // Handle error opening box
    }
  }

  // Get all posts from the box and sort them by userId
  Future<List<PostModel>> getPostsFrom() async {
    try {
      var posts = _postBox.values.toList();
      posts.sort((a, b) => a.userId.compareTo(b.userId));
      return posts;
    } catch (e) {
      // Handle error getting posts
      return [];
    }
  }

  // Add more posts to the box
  Future<void> addMorePost(List<PostModel> posts) async {
    try {
      final bool con = await checkInternetConnection();
      // Check if the box is full and there's internet connection to clear posts
      if (_postBox.length >= 100 && con) {
        crelarPosts();
      }
      await _postBox.addAll(posts);
    } catch (e) {
      // Handle error adding posts
    }
  }

  // Clear all posts from the box
  Future<int> crelarPosts() async {
    try {
      return _postBox.clear();
    } catch (e) {
      // Handle error clearing posts
      return 1;
    }
  }
}

// Adapter for serializing/deserializing PostModel objects
class PostAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  // Deserialize binary data to PostModel object
  @override
  PostModel read(BinaryReader reader) {
    var fields = reader.readMap();
    return PostModel(
      id: fields['id'] as int,
      userId: fields['userId'] as int,
      title: fields['title'] as String,
      body: fields['body'] as String,
    );
  }

  // Serialize PostModel object to binary data
  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer.writeMap({
      'id': obj.id,
      'userId': obj.userId,
      'title': obj.title,
      'body': obj.body,
    });
  }
}
