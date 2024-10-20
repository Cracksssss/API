import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cat_fact.dart';

class ApiService {
  final String baseUrl = 'https://catfact.ninja/fact';

  Future<CatFact> fetchCatFact() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return CatFact.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cat fact');
    }
  }
}