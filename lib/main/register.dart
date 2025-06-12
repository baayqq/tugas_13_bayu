import 'package:flutter/material.dart';
// Import SharedPreferences untuk menyimpan data secara lokal
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_13_bayu/main/login.dart';
import 'package:tugas_13_bayu/database/prefrendb.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final _formKey = GlobalKey<FormState>();

  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  Future<void> _simpanData() async {
    await PrefRenDB.saveUser(
  username: _usernameController.text,
  email: _emailController.text,
  password: _passwordController.text,
); 

    
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data berhasil disimpan!')));

    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Color(0xFFF1F8E9),
      body: Form(
        key: _formKey, 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Silakan Daftar Terlebih Dahulu'),
              SizedBox(height: 40),

              // Input Username
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Username wajib diisi'
                            : null,
              ),

              SizedBox(height: 8),

              // Input Email
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

              // Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: true, // agar karakter disembunyikan
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
                        value == null || value.length < 6
                            ? 'Minimal 6 karakter'
                            : null,
              ),

              SizedBox(height: 16),

              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    
                    _simpanData();
                  }
                },
                child: Text('Daftar'),
              ),

              SizedBox(height: 24),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: TextStyle(color: Color(0xff888888)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Sign in"),
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
