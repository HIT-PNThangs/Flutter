import 'package:flutter/material.dart';
import 'package:whats_app_flutter/constants/colors.dart';
import 'package:whats_app_flutter/constants/persons.dart';
import 'package:whats_app_flutter/views/home/home_widgets.dart';
import 'package:whats_app_flutter/widgets/common/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.transparent,
          // child: GradientIconButton(iconData: Icons.search, size: 32),
          child: GradientIconButton(iconData: Icons.group_add, size: 55)
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Chats",
                      style:
                      TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: blackColor(context).darkColor,
                      )
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.group_add, size: 32, color: greenColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
            Padding(
              padding:
              const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GradientIconButton(
                        iconData: Icons.search, size: 60, text: "New Status", ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              persons.length,
                                  (index) => StoryWidget(
                                  imageUrl: persons[index]['picture'].toString(),
                                  size: 60,
                                  text: "${persons[index]['title']}",
                                  showGreenStrip: true)
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            const Divider(thickness: 1),
            Expanded(
                child: ListView.separated(
                    itemCount: persons.length,
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1);
                    },
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => HomeListTile(
                        context: context,
                        imageUrl: persons[index]['picture'].toString(),
                        title: "${persons[index]['first_name']} ${persons[index]['last_name']}",
                        messageCounter: 4,
                        isOnline: true,
                        tiles: index == 3 ? homeTiles.group : homeTiles.message,
                        subTitle: "subTitle",
                        time: "19:00"
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}