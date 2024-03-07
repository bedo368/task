import 'package:flutter/material.dart';

class PostScreenTopBar extends StatelessWidget {
  const PostScreenTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.25),
            offset: const Offset(0, 1),
            spreadRadius: -2,
            blurRadius: 15)
      ]),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "posts",
              style: TextStyle(
                color: Color(0xff2F2D2C),
                fontSize: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 25,
              color: Color(0xff2F2D2C),
            ),
          )
        ],
      ),
    );
  }
}
