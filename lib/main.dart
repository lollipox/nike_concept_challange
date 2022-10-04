import 'package:flutter/material.dart';

import 'package:nike_concept/list.dart';
import 'package:nike_concept/notch_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOdd = false;

  Color get _labelColor {
    return isOdd ? Colors.white : Colors.orange;
  }

  onScrollChanged(int page) => setState(() => isOdd = page.isOdd);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: _labelColor,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                  size: 40,
                ),
              ),
              const NotchIcon(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                labelColor: _labelColor,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                tabs: const [
                  Tab(text: 'Basketball'),
                  Tab(text: 'Running'),
                  Tab(text: 'Training'),
                ],
              ),
            ),
          ),
          title: Row(
            children: [
              const SizedBox(width: 20),
              Image.asset('assets/nike_w.png'),
              const Spacer(),
              const Icon(Icons.menu),
              const SizedBox(width: 16),
              const Icon(Icons.backpack),
              const SizedBox(width: 20),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            color: Colors.black,
            child: TabBarView(
              children: [
                ProductList(onScrollChanged: onScrollChanged),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
