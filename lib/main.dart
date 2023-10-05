import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _resultsController = TextEditingController();
  String _response = '';
  int _time = 0;

  Future<void> _search() async {
    String query = _queryController.text;
    int results = int.parse(_resultsController.text);

    // Make API request
    var apiUrl = Uri.parse('http://localhost:3000/search');

    var body = jsonEncode({'query': query, 'count': results.toString()});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(apiUrl, body: body, headers: headers);

    // Parse response
    var data = json.decode(response.body);
    List<String> resultList = List<String>.from(data['data']);
    int time = data['timeTaken'];

    setState(() {
      _response = resultList.join('\n');
      _time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Search App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(labelText: 'Query'),
            ),
            TextField(
              controller: _resultsController,
              decoration: const InputDecoration(labelText: 'Number of Results'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _search,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16.0),
            const Text('Response:'),
            Text(_response),
            const SizedBox(height: 16.0),
            Text('Time: $_time ms'),
          ],
        ),
      ),
    );
  }
}
