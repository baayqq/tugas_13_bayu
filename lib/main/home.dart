import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shoes Store',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 800,
                child: GridView.count(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu1.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu2.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu3.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu4.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu5.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu6.jpg",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu7.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/sepatu8.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
