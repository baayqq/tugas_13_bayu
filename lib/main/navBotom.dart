import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/listproduct.dart';
import 'package:tugas_13_bayu/main/login.dart';
import 'package:tugas_13_bayu/main/profil.dart';
import 'package:tugas_13_bayu/main/report.dart';
import 'package:tugas_13_bayu/main/tambah.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroke_text/stroke_text.dart';

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

  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Tidak diketahui';
      _email = prefs.getString('email') ?? 'Tidak diketahui';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StrokeText(
          text: "Footwear Store",
          textStyle: TextStyle(fontSize: 36, color: Colors.black),
          strokeColor: (Color(0xFFF1F8E9)),
          strokeWidth: 4,
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF1F8E9), Colors.greenAccent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                CircleAvatar(
                  backgroundColor: Color(0xFFF1F8E9),
                  radius: 60,
                  child: Icon(
                    Icons.account_circle,
                    size: 120,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome $_username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );
                  },
                ),
                SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
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
