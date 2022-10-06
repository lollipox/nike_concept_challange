import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_concept/details.dart';

class Product {
  final List<String> images;
  final int price;
  final String title;
  final String subtitle;

  Product(this.images, this.price, this.title, this.subtitle);
}

final list = [
  Product(['assets/J_1.png', 'assets/J_2.png', 'assets/J_3.png'], 850,
      'Nike Air', 'Air Jordan 1 Mid SE GC'),
  Product(['assets/N_1.png', 'assets/N_2.png', 'assets/N_3.png'], 1449,
      'Nike Max', 'Nike Air MAX 97\'Olympic Gold'),
  Product(['assets/Z_1.png', 'assets/Z_2.png', 'assets/Z_3.png'], 649,
      'Nike Air', 'Air Jordan 1 White'),
];

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
    required this.onScrollChanged,
  }) : super(key: key);

  final ValueChanged<int> onScrollChanged;

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
      widget.onScrollChanged(_controller.page!.round());
    });
    super.initState();
  }

  goToDetails(Product product) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, secondaryAnimation) =>
            DetailsPage(product: product),
        transitionsBuilder: (_, animation, ___, child) {
          const begin = Offset(0.0, 0.15);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
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
                child: ProductCard(
                  product: list[index],
                  disabled: index.isOdd && _currentPage.round() == index,
                  onPressed: () => goToDetails(list[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onPressed,
    this.disabled = false,
  });

  final Product product;
  final bool disabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
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
                      style: GoogleFonts.fredokaOne(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200],
                      ),
                    ),
                  )),
              Transform.translate(
                offset: const Offset(35, 0),
                child: Hero(
                  tag: product.images[0],
                  child: Image.asset(product.images[0]),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AnimatedContainer(
                  width: 100,
                  height: 100,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: disabled ? Colors.white : Colors.orange,
                    borderRadius: const BorderRadius.only(
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
      ),
    );
  }
}
