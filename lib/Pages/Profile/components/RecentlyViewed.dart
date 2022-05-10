import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/Product.dart';

import '../../../src/Widget/constants.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({Key? key}) : super(key: key);

  @override
  State<RecentlyViewed> createState() => RecentlyViewedState();
}

class RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recently viewed"),
        backgroundColor: Global.green,
      ),
      body: Container(
          padding: const EdgeInsets.all(Global.defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: demo_productsModel.length,
                  itemBuilder: (context, index) {
                    final product = demo_productsModel[index];
                    return productCard(product);
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget productCard(ProductModel product) {
    return Column(
      children: [
        Container(
          //padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Global.darkGreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.asset(
                  product.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(product.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Global.white,
                            )),
                        const SizedBox(width: 8),
                        Text(
                          product.location!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.category!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Text("KES ${product.price.toString()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Global.white,
                      )))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
