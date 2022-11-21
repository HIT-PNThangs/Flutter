import 'package:design_ui1/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'theme/app_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/image1.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 40.0.sp,
                        width: 150.0.sp,
                        decoration: BoxDecoration(color: const Color(0xff242424), borderRadius: BorderRadius.circular(8.0.sp)),
                        child: Row(
                          children: [
                            SizedBox(width: 8.0.sp),
                            const Icon(
                              Icons.photo_album_outlined,
                              color: AppColors.orange,
                            ),
                            SizedBox(width: 8.0.sp),
                            Text('Your album', style: TextStyle(color: AppColors.orange, fontSize: 16.0.sp))
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 8.0.sp,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 40.0.sp,
                        width: 150.0.sp,
                        decoration: BoxDecoration(color: const Color(0xff242424), borderRadius: BorderRadius.circular(8.0.sp)),
                        child: Row(
                          children: [
                            SizedBox(width: 8.0.sp),
                            const Icon(
                              Icons.photo_album_outlined,
                              color: AppColors.orange,
                            ),
                            SizedBox(width: 8.0.sp),
                            Text('Your album', style: TextStyle(color: AppColors.orange, fontSize: 16.0.sp))
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 24.0.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(color: const Color(0xff242424), borderRadius: BorderRadius.circular(24.0.sp)),
                    child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Close",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.close),
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
