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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          height: 80,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(60)),
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
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                tabs: [
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
                const ProductList(),
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
