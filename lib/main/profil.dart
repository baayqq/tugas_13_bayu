import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadUserData(); // Panggil fungsi untuk ambil data
  }

  // Fungsi untuk mengambil data dari SharedPreferences
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
        title: Text('Profil Akun'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, $_username!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 16),
            ),
            // Tambahkan elemen lain jika perlu
          ],
        ),
      ),
    );
  }
}