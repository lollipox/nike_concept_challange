import 'dart:ui';

import 'package:flutter/material.dart';

class Product {
  final String image;
  final int price;
  final String title;
  final String subtitle;

  Product(this.image, this.price, this.title, this.subtitle);
}

final list = [
  Product('assets/J_001.png', 850, 'Nike Air', 'Air Jordan 1 Mid SE GC'),
  Product('assets/N_001.png', 649, 'Nike Air', 'Air Jordan 1 White'),
  Product(
      'assets/Z_003.png', 1449, 'Nike Max', 'Nike Air MAX 97\'Olympic Gold'),
];

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.73);

  double _currentPage = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() => _currentPage = _controller.page!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 480,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PageView.builder(
            pageSnapping: true,
            controller: _controller,
            padEnds: true,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, index) {
              double top = lerpDouble(_currentPage, index, 35) ?? 0;

              return AnimatedContainer(
                margin: EdgeInsets.only(right: 40, top: top.abs()),
                duration: const Duration(milliseconds: 50),
                child: ProductCard(product: list[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title.toUpperCase()),
                    Text(product.subtitle.toUpperCase()),
                    Text('\$${product.price}'),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    product.title.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                  ),
                )),
            Transform.translate(
              offset: const Offset(35, 0),
              child: Image.asset('assets/J_001.png'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Icon(Icons.add, size: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
