import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/loading_overlay.dart';
import 'components/posts_list_item.dart';
import 'posts_controller.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: GetBuilder<PostsController>(
        builder: (controller) {
          return LoadingOverlay(
            isLoading: controller.isLoading,
            child: ListView.builder(
              itemCount: controller.postsList.length,
              itemBuilder: (context, index) => PostsListItem(
                post: controller.postsList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
