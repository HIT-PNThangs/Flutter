import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation/constants.dart';
import 'package:meditation/widgets/bottom_navigation.dart';
import 'package:meditation/widgets/search_bar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.45,
            decoration: const BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              )
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Meditation",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "3-10 MIN Course",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: const Text(
                        "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child: const SearchBar(),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                         SeasonCart(numberSeason: 1, isDone: true, press: () {}),
                         SeasonCart(numberSeason: 2, press: () {}),
                         SeasonCart(numberSeason: 3, press: () {}),
                         SeasonCart(numberSeason: 4, press: () {}),
                         SeasonCart(numberSeason: 5, press: () {}),
                         SeasonCart(numberSeason: 6, press: () {}),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Mediation",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 90,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: kShadowColor
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Meditation_women_small.svg",
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Basic 2",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const Text(
                                  "Start your deepen you practice",
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/Lock.svg"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}

class SeasonCart extends StatelessWidget {
  final int numberSeason;
  final bool isDone;
  final void Function() press;

  const SeasonCart({
    Key? key,
    required this.numberSeason,
    this.isDone = false,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 10,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 17),
                    blurRadius: 23,
                    spreadRadius: -13,
                    color: kShadowColor
                )
              ]
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kBlueColor
                        )
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Season $numberSeason",
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}