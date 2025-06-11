import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/home.dart';
import 'package:tugas_13_bayu/main/tambah.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  int _pilihIndex = 0;
  static const List<Widget> _butonNavigator = <Widget>[
    HomePage(title: 'Home'),
    AddProduct(title: 'Tambah Produk'),
    EditPage(title: 'Edit'),
  ];

  void _pilihNavigator(int index) {
    setState(() {
      _pilihIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _butonNavigator.elementAt(_pilihIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
        ],
        currentIndex: _pilihIndex,
        selectedItemColor: Colors.amber,
        onTap: _pilihNavigator,
      ),
    );
  }
}
