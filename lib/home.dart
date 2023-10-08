import 'package:flutter/material.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Input box listeners
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _resultsCountController = TextEditingController();

  // Api interaction
  String _response = '';
  int _time = 0;

  final ApiService _apiService = ApiService();

  Future<void> _search() async {
    String query = _queryController.text;
    int resultsCount = int.parse(_resultsCountController.text);

    var data = await _apiService.search(query, resultsCount);
    List<String> responseList = List<String>.from(data['data']);
    int time = data['time'];

    setState(() {
      _response = responseList.join('\n');
      _time = time;
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Search App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _search,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                labelText: 'Query',
                prefixIcon: Icon(Icons.query_builder),
              ),
            ),
            TextField(
              controller: _resultsCountController,
              decoration: const InputDecoration(
                labelText: 'Number of Results',
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _search,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Response:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(_response),
            const SizedBox(height: 16.0),
            Text(
              'Time: $_time ms',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
