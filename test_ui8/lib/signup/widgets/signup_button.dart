import 'package:flutter/material.dart';

Widget signupButton(title) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 18.0),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 32.0)),
          ],
          borderRadius: BorderRadius.circular(36.0),
          gradient:
              const LinearGradient(begin: FractionalOffset.centerLeft, stops: [
            0.2,
            1
          ], colors: [
            Color(0xff000000),
            Color(0xff434343),
          ])),
      child: Text(
        title,
        style: const TextStyle(
            color: Color(0xffF1EA94),
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
      ),
    ),
  );
}
