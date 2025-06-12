import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_13_bayu/database/prefrendb.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
  final username = await PrefRenDB.getUsername();
  final email = await PrefRenDB.getEmail();

  setState(() {
    _username = username ?? 'Tidak diketahui';
    _email = email ?? 'Tidak diketahui';
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Akun'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Color(0xFFF1F8E9),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Profil Pengguna", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Text("Username: $_username"),
      SizedBox(height: 8),
      Text("Email: $_email"),
    ],
  ),
),
    );
  }
}