import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/Product.dart';

class ItemCart extends StatelessWidget {
  final Product product;
  final void Function() press;

  const ItemCart({
    Key? key,
    required this.product,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.asset(product.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              product.title,
              style: const TextStyle(
                  color: kTextLightColor
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              "\$${product.price}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}