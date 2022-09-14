import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screen/components/category.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
              "Women",
              style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Categories(),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => const ItemCart(),
              ),
            )
        )
      ],
    );
  }
}

class ItemCart extends StatelessWidget {
  final Product? product;
  final Function? press;
  const ItemCart({
    Key? key,
    this.product,
    this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          height: 180,
          width: 160,
          decoration: BoxDecoration(
              color: products[0].color,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Image.asset(products[0].image),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
          child: Text(
            products[0].title,
            style: const TextStyle(
                color: kTextLightColor
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
          child: Text(
            "\$${products[0].price}",
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}
