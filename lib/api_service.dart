import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class ApiService {
  // Api call constants
  var apiUrl = Uri.parse('http://localhost:3000/search');
  var headers = {'Content-Type': 'application/json'};

  // final log = Logger("ApiLogger");

  Future<Map<String, dynamic>> search(String query, int results) async {
    var body = jsonEncode({'query': query, 'results': results.toString()});

    try {
      var response = await http.post(apiUrl, body: body, headers: headers);

      if (response.statusCode == 400) {
        throw Exception(
            'Incorrect input. Please check your query and number of results.');
      } else if (response.statusCode == 404) {
        throw Exception(
            'The API service is currently unavailable. Please try again later.');
      } else if (response.statusCode != 200) {
        throw Exception('An error occurred. Please try again.');
      }

      return json.decode(response.body);
    } catch (e) {
      // logger.log(
      // Level.error, "An error occurred while calling the API service.", e);
      // logger.e(e);
      rethrow;
    }
  }
}
