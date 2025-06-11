import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Tambahkan
import 'package:tugas_13_bayu/main/navBotom.dart';
import 'package:tugas_13_bayu/main/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(); // ✅ Tambahkan
  final TextEditingController _passwordController =
      TextEditingController(); // ✅ Tambahkan
  final _formKey = GlobalKey<FormState>(); // ✅ Tambahkan

  // Fungsi untuk memvalidasi login
  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    final inputEmail = _emailController.text;
    final inputPassword = _passwordController.text;

    // ✅ Cek apakah email & password cocok
    if (inputEmail == savedEmail && inputPassword == savedPassword) {
      // Berhasil login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeBottom()),
      );
    } else {
      // Gagal login
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email atau Password salah')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ✅ Tambahkan key untuk validasi form
          child: Column(
            children: [
              Text('Silakan login terlebih dahulu'),
              SizedBox(height: 40),

              // ✅ Input Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Email wajib diisi'
                            : null,
              ),

              SizedBox(height: 8),

              // ✅ Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Password wajib diisi'
                            : null,
              ),

              SizedBox(height: 16),

              // ✅ Tombol Login
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login(); // jalankan validasi login
                  }
                },
                child: Text('Login'),
              ),

              SizedBox(height: 24),

              // ✅ Navigasi ke Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: TextStyle(fontSize: 14, color: Color(0xff888888)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
