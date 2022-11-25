import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget topMenu() {
  return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  FontAwesomeIcons.plane,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Flights",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
                  child: const Icon(
                    FontAwesomeIcons.hotel,
                    color: Colors.white,
                    size: 18.0,
                  )),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Hotels",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: const Icon(
                  FontAwesomeIcons.train,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Trains",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                child: const Icon(
                  FontAwesomeIcons.car,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Cars",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          )
        ],
      ));
}
