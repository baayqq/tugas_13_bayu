import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/listproduct.dart';
import 'package:tugas_13_bayu/main/tambah.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, this.title = 'Home'});

  @override
  State<HomePage> createState() => _DrawpageState();
}

class _DrawpageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> listScreen = [ListProd(), AddProduct(), EditPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: listScreen[_selectedIndex],
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/sepatu3.jpg"),
              ),
              SizedBox(height: 20),
              Text(
                "Bayu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('home'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.dark_mode_outlined),
                title: Text('tambah'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.list_sharp),
                title: Text('edit'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
