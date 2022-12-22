import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() => runApp(
      ButtonApp(),
    );

class ButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _messages = [];
  Future<http.Response> _postEvent() async {
    final data = {
      "event": {"iduff": "iduff"}
    };
    final http.Response response = await http.post(
      Uri.parse('http://localhost:3000/events'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    setState(() {
      _messages.add("Alerta gerado!");
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Botão SOS"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/BotãoSOS-Logo.png"),
              height: 60,
              margin: EdgeInsets.all(20),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _postEvent,
              child: Icon(
                Icons.sos,
                size: 150,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).errorColor), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(_messages.length == 0 ? "" : _messages.last),
            ),
          ],
        ),
      ),
    );
  }
}
