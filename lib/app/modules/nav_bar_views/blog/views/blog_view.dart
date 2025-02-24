import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/blog_controller.dart';

class BlogView extends GetView<BlogController> {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlogView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                //controller.search.value = value;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Ad Banner (Dummy)
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text("Ad Banner"),
            ),
            const SizedBox(height: 10),

            // Blog Post List
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 40),
                    ),
                    title: Text("title"),
                    subtitle: Text("Published on: date"),
                    onTap: () {
                      //Get.toNamed('/blog-details', arguments: post);
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),

            // View More Button
            ElevatedButton(
              onPressed: () {
                //controller.loadMorePosts();
              },
              child: const Text("View More"),
            ),
          ],
        ),
      ),
    );
  }
}
