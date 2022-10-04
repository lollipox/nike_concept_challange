import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_concept/list.dart';

class PrimaryColorProvider extends InheritedWidget {
  const PrimaryColorProvider({
    super.key,
    required super.child,
    this.color = Colors.orange,
  });

  final Color color;

  static PrimaryColorProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PrimaryColorProvider>()!;

  @override
  bool updateShouldNotify(covariant PrimaryColorProvider oldWidget) =>
      oldWidget.color != color;
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double activeSize = 0.8;
  Color activeColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PrimaryColorProvider(
        color: activeColor,
        child: Stack(
          children: [
            TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: width / 2.5,
                  end: width * 1.1,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, size, child) {
                  return Positioned(
                    top: -width * 0.2,
                    right: -width * 0.5,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(size),
                      ),
                    ),
                  );
                }),
            Positioned(
              top: kToolbarHeight + 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      maximumSize: const Size(40, 40),
                      minimumSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: height * 0.2,
              left: 10,
              right: 10,
              child: FittedBox(
                child: Text(
                  widget.product.title.toUpperCase(),
                  style: GoogleFonts.fredokaOne(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Stack(
                    children: [
                      Hero(
                        tag: widget.product.image,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: activeSize,
                          child: Image.asset(widget.product.image),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title.toUpperCase(),
                    style: GoogleFonts.fredokaOne(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.subtitle.toUpperCase(),
                        style: GoogleFonts.fredokaOne(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '\$${widget.product.price}',
                        style: GoogleFonts.fredokaOne(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    unratedColor: Colors.white,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: const EdgeInsets.only(right: 8),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: activeColor),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 20),
                  SizesToolbar(
                    onSizeChanged: (value) {
                      setState(() => activeSize = value);
                    },
                    activeSize: activeSize,
                  ),
                  const SizedBox(height: 20),
                  SneakersColors(onColorChanged: (value) {
                    setState(() => activeColor = value);
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SizesToolbar extends StatelessWidget {
  const SizesToolbar({
    Key? key,
    required this.onSizeChanged,
    required this.activeSize,
  }) : super(key: key);

  final ValueChanged<double> onSizeChanged;

  final List<int> _sizes = const [7, 8, 9, 10];
  final double activeSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SIZE',
          style: GoogleFonts.fredokaOne(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          children: List.generate(
            _sizes.length,
            (index) => SizeButton(
              active: _sizes[index] * 0.1 == activeSize,
              size: _sizes[index],
              onPressed: onSizeChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class SizeButton extends StatelessWidget {
  const SizeButton({
    Key? key,
    required this.active,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  final bool active;
  final int size;
  final ValueChanged<double> onPressed;

  @override
  Widget build(BuildContext context) {
    final activeColor = PrimaryColorProvider.of(context).color;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 50),
        maximumSize: const Size(50, 50),
        padding: EdgeInsets.zero,
        backgroundColor: active ? activeColor : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: Colors.orange,
      ),
      onPressed: () => onPressed(size * 0.1),
      child: Center(
        child: Text(
          size.toString(),
          style: GoogleFonts.fredokaOne(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SneakersColors extends StatelessWidget {
  const SneakersColors({
    Key? key,
    required this.onColorChanged,
  }) : super(key: key);

  final List<Color> _colors = const [Colors.orange, Colors.red, Colors.grey];

  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    final activeColor = PrimaryColorProvider.of(context).color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'COLOR',
              style: GoogleFonts.fredokaOne(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(
                _colors.length,
                (index) => GestureDetector(
                  onTap: () => onColorChanged(_colors[index]),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _colors[index],
                      border: Border.all(
                        width: 2,
                        color: activeColor == _colors[index]
                            ? Colors.white
                            : _colors[index],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 120,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: activeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'BUY',
              style: GoogleFonts.abel(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
