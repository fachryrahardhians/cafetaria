import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeItemInfo extends StatelessWidget {
  const HomeItemInfo({
    Key? key,
    required this.image,
    required this.title,
    required this.author,
    this.route,
  }) : super(key: key);

  final String image;
  final String title;
  final String author;
  final VoidCallback? route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: route,
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: Text(
              title,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: Text(
              author,
              style: const TextStyle(color: MyColors.grey3),
            ),
          ),
        ],
      ),
    );
  }
}
