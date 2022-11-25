import 'package:flutter/material.dart';

import '../model/destination.dart';

final destinationItems = <Destination>[
  Destination(
      title: "Nice Country",
      image:
          "https://images.pexels.com/photos/14437082/pexels-photo-14437082.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      country: "Mongolia"),
  Destination(title: "Abu Dhabi", image: "https://images.pexels.com/photos/14437082/pexels-photo-14437082.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", country: "Dubai"),
  Destination(
      title: "A Place to be: Berlin",
      image:
          "https://images.pexels.com/photos/14437082/pexels-photo-14437082.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      country: "Germany"),
];
final dealsItems = <String>[
  "https://images.pexels.com/photos/14437082/pexels-photo-14437082.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://cdn.theculturetrip.com/wp-content/uploads/2015/11/New-Zealand-©-vichie81-Shutterstock.jpg",
  "https://pullman.accorhotels.com/destinations/country/new-zealand-1400x788-1.jpg",
  "https://images.pexels.com/photos/14437082/pexels-photo-14437082.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
];

Widget destination(BuildContext context) {
  return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Destinations we love",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Text(
                  "View all",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                )
              ],
            ),
          ),
          SizedBox(
              height: 230,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: destinationItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 300,
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill, image: NetworkImage(destinationItems[index].image)))),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              destinationItems[index].title,
                              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              destinationItems[index].country,
                              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                            )
                          ],
                        ));
                  })),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Deals",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Text(
                  "View all",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                top: false,
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: dealsItems.map<Widget>((String image) {
                      return Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)))));
                    }).toList(),
                  ),
                )),
          )
        ],
      ));
}
