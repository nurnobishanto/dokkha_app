import 'package:flutter/material.dart';

Widget buildTopRankedUser(
    {required String imagePath,
      required String name,
      required int rank,
      bool isFirst = false}) {
  return Column(
    children: [
      CircleAvatar(
        radius: isFirst ? 53 : 38,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          radius: isFirst ? 50 : 35,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
      const SizedBox(height: 5.00),
      CircleAvatar(
        radius: 12,
        backgroundColor: Colors.blue,
        child: Text(
          rank.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        "score",
        style: TextStyle(color: Colors.black),
      ),
    ],
  );
}