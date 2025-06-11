import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/listproduct.dart';
import 'package:tugas_13_bayu/main/login.dart';
import 'package:tugas_13_bayu/main/report.dart';
import 'package:tugas_13_bayu/main/tambah.dart';
import 'package:intl/intl.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  int _pilihIndex = 0;
  static const List<Widget> _butonNavigator = <Widget>[
    ListProd(title: 'Home'),
    AddProduct(title: 'Tambah Produk'),
    EditPage(title: 'Edit'),
    ReportPage(),
  ];

  void _pilihNavigator(int index) {
    setState(() {
      _pilihIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ntc Store', style: TextStyle(color: Color(0xFFF1F8E9))),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 4,
        backgroundColor: Color(0xFFF1F8E9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 60,
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Color(0xFFF1F8E9),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Bayu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.manage_accounts),
                title: Text('Profile'),
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _butonNavigator[_pilihIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_rounded),
            label: 'Report',
          ),
        ],
        backgroundColor: Colors.greenAccent,
        currentIndex: _pilihIndex,
        selectedItemColor: Color(0xFFF1F8E9),
        onTap: _pilihNavigator,
      ),
    );
  }
}
