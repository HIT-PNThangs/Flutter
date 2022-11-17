import 'dart:async';

import 'package:flutter/material.dart';

import '../const/color_const.dart';
import '../const/gradient_const.dart';
import '../const/images_const.dart';
import '../const/size_const.dart';
import 'widgets/signup_apbar.dart';
import 'widgets/signup_arrow_button.dart';

class SignPageEleven extends StatefulWidget {
  const SignPageEleven({super.key});

  @override
  _SignPageElevenState createState() => _SignPageElevenState();
}

class _SignPageElevenState extends State<SignPageEleven> {
  String _currentDate = 'Select Date';
  final List _locations = ["Istanbul", "Frankfurt", "Barcelona", "Shangay"];
  String _currentLocation = "Frankfurt";
  final TextEditingController _controller = TextEditingController();

  void changeDropDownLocationItem(String selectedLocation) {
    setState(() {
      _currentLocation = selectedLocation;
    });
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2050));
    if (picked != null) {
      setState(
        () => _currentDate = picked.toString(),
      );
    }
  }

  bool _male = true;
  bool _famele = false;

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const SignupApbar(
        title: "CREATE ACCOUNT",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Container(
              height: _media.height,
              width: _media.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    SignUpImagePath.SignUpPage_11_Bg,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const SignUpArrowButton(
                  height: 70,
                  width: 70,
                  icon: IconData(0xe903, fontFamily: 'Icons'),
                  iconSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Upload Profile Picture",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                dateColorBox(
                    SIGNUP_BACKGROUND, "BIRTHDAY", _currentDate, _selectDate),
                shadowColorBox(
                    SIGNUP_CARD_BACKGROUND, "GENDER", "Male", "Famale"),
                Wrap(children: <Widget>[
                  locationColorBox(
                      SIGNUP_BACKGROUND, "LOCATION", _currentLocation),
                ]),
                fieldColorBox(
                    SIGNUP_BACKGROUND, "USERNAME", "hitatal123", _controller),
                const SizedBox(
                  height: 30,
                ),
                nexButton("NEXT"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget locationColorBox(
      Gradient gradient, String title, String currentLocation) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30,
        bottom: 8,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 30,
              offset: Offset(1.0, 9.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: TEXT_SMALL_SIZE, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: const TextStyle(
                    fontSize: TEXT_NORMAL_SIZE,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownLocationItem,
                  items: _locations.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentLocation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shadowColorBox(
      Gradient gradient, String title, String male, String famale) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30,
        bottom: 8,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 30,
              offset: Offset(1.0, 9.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: TEXT_SMALL_SIZE, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      male,
                      style: TextStyle(
                        fontSize: 12,
                        color: _male ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      setState(() {
                        _famele = false;
                        _male = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Text(
                      famale,
                      style: TextStyle(
                        fontSize: 12,
                        color: _famele ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      setState(() {
                        _famele = true;
                        _male = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldColorBox(Gradient gradient, String title, String text,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30,
        bottom: 8,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 30,
              offset: Offset(1.0, 9.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: TEXT_SMALL_SIZE, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: <Widget>[
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: text,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                            fontSize: TEXT_NORMAL_SIZE, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateColorBox(
      Gradient gradient, String title, String data, Function function) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30,
        bottom: 8,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: TEXT_SMALL_SIZE, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: <Widget>[
                  TextButton(
                    onPressed: function,
                    child: Text(
                      data,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nexButton(String text) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 120,
        decoration: BoxDecoration(
          gradient: SIGNUP_CIRCLE_BUTTON_BACKGROUND,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: YELLOW,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_NORMAL_SIZE,
          ),
        ),
      ),
      onTap: () => debugPrint("Next tapped"),
    );
  }
}
