import 'package:flutter/material.dart';

import '../../util/transformer_page_view.dart';
import 'ProductDetailView.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProductListViewState();
  }
}

class ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductList"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100.0,
            child: TransformerPageView(
              viewportFraction: 0.8,
              itemCount: 10,
              transformer: PageTransformerBuilder(builder: (w, i) {
                return w;
              }),
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return const ProductDetailView();
                    }));
                  },
                  child: Container(
                    color: Colors.black26,
                    child: Text("$i"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
