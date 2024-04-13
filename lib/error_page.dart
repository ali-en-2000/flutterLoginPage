import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Errore'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUser,
      ),
      body: const Center(
          child: Text(
        'This is error page.',
        style: TextStyle(fontSize: 20),
      )),
    );
  }

  void fetchUser() async {
    print('hi');
    const url = "https://jsonplaceholder.typicode.com/todos/1";
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      print('Response: $jsonData');
    } else {
      print('Request failed with status: ${res.statusCode}');
    }
  }
}
