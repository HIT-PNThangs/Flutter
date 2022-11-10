import 'package:flutter/material.dart';
import 'package:social_media_app/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routerName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.add_circle),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.message),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ProfileScreen();
                  }));
                },
                color: Colors.white,
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextButton(context, 'For you'),
          _buildTextButton(context, 'Following'),
        ],
      ),
    );
  }

  TextButton _buildTextButton(BuildContext context, String text) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(fixedSize: const Size(100, 50)),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
