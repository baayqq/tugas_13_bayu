import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle()),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('silahkan Daftar terlebih dahulu'),
              SizedBox(height: 88),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xff789262), width: 1),
                  ),
                ),
              ),
              SizedBox(height: 8),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xff789262), width: 1),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xFFE6F0EA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xff789262), width: 1),
                  ),
                ),
              ),

              SizedBox(height: 16),
              ElevatedButton(onPressed: () {}, child: Text('Daftar')),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Sudah mempunyai akun?",
                      style: TextStyle(fontSize: 14, color: Color(0xff888888)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Sign in",
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
