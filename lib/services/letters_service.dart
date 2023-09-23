import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:http/http.dart' as http;
import 'package:letters/utils/mixins.dart';

// LetterService is a class that contains static methods to interact with the
// letters API.
//
// Members are static coz we only need one instance of this class globally.
class LetterService with Constants {
  
  // getLetters is a static method that returns a Future of List<Letter>.
  // It makes a GET request to the letters endpoint and returns a list of
  // letters.
  //
  // Returns a record of type List<Letter> and a boolean to indicate if the
  // request was successful.
  static Future<(List<Letter>, bool)> getLetters() async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}/letters'));
      if (response.statusCode != 200) throw Exception("Error Getting Letters");

      var data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      final letters = <Letter>[];
      for (var value in data) {
        letters.add(Letter.fromJson(value));
      }

      return (letters, true);
    } catch (e) {
      debugPrint("Error Getting Letters: $e");
      debugPrintStack();

      // We can attempt to get letters from the local database if the request
      // fails.

      return ([] as List<Letter>, false);
    }
  }

  // getLetter is a static method that returns a Future of Letter.
  // It makes a GET request to the letters endpoint and returns a letter.
  //
  // Returns a record of type Letter and a boolean to indicate if the
  // request was successful.
  static Future<(Letter?, bool)> getLetter(String id) async {
    assert(id.isNotEmpty, "ID cannot be empty");
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}/letters/$id'));

      if (response.statusCode != 200) throw Exception("Letter not found");

      final letter = Letter.fromJson(jsonDecode(response.body));
      return (letter, true);
    } catch (e) {
      debugPrint("Error Getting Letter: $e");
      debugPrintStack();

      // We can attempt to get letter from the local database if the request
      // fails.

      return (null, false);
    }
  }

  // createLetter is a static method that returns a Future of Letter and a
  // boolean to indicate if the request was successful.
  // It makes a POST request to the letters endpoint and returns a letter.

  static Future<(Letter?, bool)> postLetter(Map<String, String> data) async {
    assert(data.isNotEmpty, "Data cannot be empty");
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/letters'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          ...data,
          "author": "John Doe",
          "image": "https://picsum.photos/200/300",
        }),
      );

      if (response.statusCode != 201) throw Exception("Error Creating Letter");
      var createdLetter = Letter.fromJson(jsonDecode(response.body));
      return (createdLetter, true);
    } catch (e) {
      debugPrint("Error Creating Letter: $e");
      debugPrintStack();

      return (null, false);
    }
  }
}
