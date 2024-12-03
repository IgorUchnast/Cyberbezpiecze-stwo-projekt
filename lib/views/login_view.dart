import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isButtonEnabled = false; // Dodajemy stan przycisku

  // Funkcja do wysyłania danych do serwera
  Future<void> _sendData() async {
    final String identifier = _identifierController.text;
    final String password = _passwordController.text;

    if (identifier.isEmpty || password.isEmpty) {
      print("Proszę wprowadzić identyfikator i hasło");
      return;
    }

    // Tworzymy dane do wysłania
    final Map<String, String> data = {
      'identifier': identifier,
      'password': password,
    };

    // Wysyłamy dane do serwera
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/login'), // URL serwera Flask
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print("Dane wysłane pomyślnie");
      } else {
        print("Błąd: ${response.statusCode}");
      }
    } catch (e) {
      print("Błąd połączenia: $e");
    }
  }

  // Funkcja do monitorowania zmian w polach tekstowych
  void _onTextChanged() {
    setState(() {
      // Aktywuj przycisk tylko jeśli identyfikator i hasło mają co najmniej 8 znaków
      isButtonEnabled = _identifierController.text.length >= 8 &&
          _passwordController.text.length >= 8;
    });
  }

  @override
  void initState() {
    super.initState();
    _identifierController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/logo.png",
                      scale: 4,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Zaloguj się do serwisu transakcyjnego",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Image.asset("images/image1.png"),
              ],
            ),
            Stack(
              children: [
                BackGroundContainer(
                  screenSize: screenSize.width,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Row(
                    children: [
                      Container(
                        width: 300,
                        color: const Color.fromARGB(255, 236, 225, 225),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                              child: Image.asset(
                                "images/image.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                                right: 10,
                                left: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                "Klienci indywidualni i firmowi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            Image.asset("images/avatar_retail.png"),
                            TextFieldView(
                              controller: _identifierController,
                              textHint: "Identyfikator",
                            ),
                            TextFieldView(
                              controller: _passwordController,
                              textHint: "Hasło",
                            ),
                            GestureDetector(
                              onTap: isButtonEnabled
                                  ? _sendData
                                  : null, // Umożliwiamy kliknięcie tylko jeśli przycisk jest aktywowany
                              child: Container(
                                margin: const EdgeInsets.only(top: 25),
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: isButtonEnabled
                                      ? Colors.green
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Zaloguj się",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              color: Colors.white,
                              child: const Row(
                                children: [
                                  Text(
                                    "Odblokuj dostęp",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 55,
                                  ),
                                  Text(
                                    "Problem z zalogowaniem?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 500,
                  left: screenSize.width * 0.25,
                  child: Image.asset("images/adv.png"),
                ),
              ],
            ),
            Container(
              height: 300,
              width: screenSize.width,
              color: Colors.white,
              child: Image.asset("images/img.png"),
            ),
          ],
        ),
      ),
    );
  }
}

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({
    super.key,
    required this.screenSize,
  });
  final double screenSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize,
      height: 600,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 285,
                child: Image.asset(
                  "images/background.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            top: 80,
            left: 400,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Private Banking",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "images/avatar_pb.png",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 220,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "CompanyNet",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "images/person.png",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}

class TextFieldView extends StatelessWidget {
  const TextFieldView({
    super.key,
    required this.controller,
    required this.textHint,
  });
  final TextEditingController controller;
  final String textHint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: textHint,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        obscureText: textHint == "Hasło" ? true : false,
      ),
    );
  }
}
