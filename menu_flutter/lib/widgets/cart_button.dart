import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final int? counter;
  final VoidCallback? addToCart;

  const CartButton({super.key, this.counter, this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: SizedBox(
        width: 70.0,
        height: 50.0,
        child: MaterialButton(
          highlightColor: Colors.amber[400],
          onPressed: counter == 0 ? null : addToCart,
          elevation: counter == 0 ? 10.0 : 5.0,
          color: counter == 0 ? Colors.grey[350] : Colors.amber,
          child: const Icon(IconData(0xe807, fontFamily: 'fontello'),
              size: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
