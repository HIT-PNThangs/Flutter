import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/Product.dart';

import 'cart_counter.dart';
import 'color_and_size.dart';
import 'title_and_price.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.35),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPadding
                  ),
                  height: 1000,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )
                  ),
                  child: Column(
                    children: [
                      ColorAndSize(product: product),
                      Description(product: product),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CartCounter(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xffff6464),
                              shape: BoxShape.circle,
                            ),
                            // child: IconData(Icons.heart),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 58,
                              decoration: BoxDecoration(
                                border: Border.all(color: product.color),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                TitleAndPrice(product: product),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  final Product product;

  const Description({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Text(
          product.description,
          style: const TextStyle(height: 1.5)
      ),
    );
  }
}
