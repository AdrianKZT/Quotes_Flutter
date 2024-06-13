import 'dart:convert';
import 'package:quotes/model/quotes_model.dart';
import 'package:http/http.dart' as http;

class QuotesApi {
  final String quotesApi = "https://fcapi-1y70.onrender.com/quotes";
  final String randomQuote = "https://fcapi-1y70.onrender.com/quotes/random";

  Future<List<Quotes>> getQuotes() async {
    final response = await http.get(Uri.parse(quotesApi));

    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((json) => Quotes.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  Future<Quotes> getRandomQuote() async {
    final response = await http.get(Uri.parse(randomQuote));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Quotes.fromJson(jsonData);
    } else {
      throw Exception('Failed to load random quote');
    }
  }
}

  
