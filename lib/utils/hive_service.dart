
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/src/post/post_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  late Box<PostModel> _postBox;

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Future<void> init() async {
    Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
    _postBox = await Hive.openBox<PostModel>('posts');
  }

  List<PostModel> getPosts() {
    return _postBox.values.toList();
  }
}

class PostAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  @override
  PostModel read(BinaryReader reader) {
    var fields = reader.readMap();
    return PostModel(
      id: fields['id'],
      userId: fields['UserId'],
      title: fields['title'],
      body: fields['body'],
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer.writeMap({
      "userId": obj.userId,
      'id': obj.id,
      'title': obj.title,
      'body': obj.body,
    });
  }
}
