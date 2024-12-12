import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:usdata/loginData/leadlist/leadpage.dart';

import '../token.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool isloding = false;

  void login(BuildContext context) async {
    setState(() {
      isloding = true; // Start loading
    });

    const String url = "https://crm-beta-api.vozlead.in/api/v2/account/login/";

    Map<String, String> data = {
      'username': name.text.trim(),
      'password': password.text.trim(),
    };

    final response = await http.post(
      Uri.parse(url),
      body: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        isloding = false; // Stop loading
      });

      final responseData = jsonDecode(response.body);
      token = responseData["data"]["token"];

      if (token != null && token!.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Leadpage()),
        );
      }
    } else {
      final responseData = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData["message"] ?? "Login failed"),
          duration: const Duration(seconds: 3),
        ),
      );

      setState(() {
        isloding = false; // Stop loading
      });
    }
  }

  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Login page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "User Name",
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: isloding == false
                    ? const Text("login")
                    : const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
