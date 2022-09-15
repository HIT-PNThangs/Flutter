import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/Product.dart';

import 'color_dot.dart';


class ColorAndSize extends StatelessWidget {
  final Product product;

  const ColorAndSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Color"),
              Row(
                children: const [
                  ColorDot(color: Color(0xff356c95), isSelected: true),
                  ColorDot(color: Color(0xfff8c078), isSelected: false),
                  ColorDot(color: Color(0xffa29b9b), isSelected: false)
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
                style: const TextStyle(
                  color: kTextColor,
                ),
                children: [
                  const TextSpan(
                    text: "Size\n",
                  ),
                  TextSpan(
                    text: "${product.size}",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: kTextColor,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ]
            ),
          ),
        )
      ],
    );
  }
}
