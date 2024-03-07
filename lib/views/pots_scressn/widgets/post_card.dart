import 'package:flutter/material.dart';
import 'package:task/modules/post/post_model.dart';
import 'package:task/widgets/read_more_text.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.25),
              offset: const Offset(2, 4),
              spreadRadius: 0,
              blurRadius: 3.5),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Image(image: AssetImage("./assets/user_photo.png")),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "MR : ${post.userId}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
            height: 1,
            color: const Color(0xffD6D6D6),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              post.title,
              style: const TextStyle(
                  color: Color(0xff2F2D2C),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: ReadMoreText(
                text: post.body,
                style: const TextStyle(color: Color(0xff2F2D2C), fontSize: 14),
                maxLines: 4,
              ))
        ],
      ),
    );
  }
}
