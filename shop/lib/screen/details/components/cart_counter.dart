import 'package:flutter/material.dart';
import 'package:shop/constants.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numberOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if(numberOfItems > 1) {
                setState(() {
                  numberOfItems -= 1;
                });
              }
            }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
              numberOfItems.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.headline6
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numberOfItems += 1;
              });
            }
        ),
      ],
    );
  }

  SizedBox buildOutlineButton({
    required IconData icon,
    required void Function() press
  }) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
