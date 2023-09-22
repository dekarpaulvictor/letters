import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:http/http.dart' as http;

// LetterService is a class that contains static methods to interact with the
// letters API.
//
// Members are static coz we only need one instance of this class globally.
class LetterService {
  
  // _baseUrl is a private static member that holds the base url for the API.
  static const String _baseUrl = 'https://letters-2c7e5.firebaseio.com';

  // getLetters is a static method that returns a Future of List<Letter>.
  // It makes a GET request to the letters endpoint and returns a list of
  // letters.
  //
  // Returns a record of type List<Letter> and a boolean to indicate if the
  // request was successful.
  static Future<(List<Letter>, bool)> getLetters() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/letters.json'));
      final letters = <Letter>[];

      if (response.statusCode != 200) throw Exception("Error Getting Letters");

      final Map<String, dynamic> data = response.body as Map<String, dynamic>;
      data.forEach((key, value) {
        letters.add(Letter.fromJson(value as Map<String, dynamic>));
      });

      return (letters, true);
    } catch (e) {
      debugPrint("Error Getting Letters: $e");
      debugPrintStack();
      return ([] as List<Letter>, false);
    }
  }

  // getLetter is a static method that returns a Future of Letter.
  // It makes a GET request to the letters endpoint and returns a letter.
  //
  // Returns a record of type Letter and a boolean to indicate if the
  // request was successful.
  static Future<(Letter?, bool)> getLetter(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/letters/$id.json'));

      if (response.statusCode != 200) throw Exception("Letter not found");

      final Map<String, dynamic> data = response.body as Map<String, dynamic>;
      final letter = Letter.fromJson(data);
      return (letter, true);
    } catch (e) {
      debugPrint("Error Getting Letter: $e");
      debugPrintStack();
      return (null, false);
    }
  }
}
