import 'dart:convert';
import 'package:ientc_jdls/class/characters.dart';
import 'package:http/http.dart' as http;

class Main {
  static const String _baseUrl = "https://dragonball-api.com/api/characters";

  static Future<List<CharactersDB>> fetchCharacters(
      {required int page, required int limit}) async {
    try {
      final url = Uri.parse("$_baseUrl?page=$page&limit=$limit");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('items')) {
          List<dynamic> items = jsonResponse['items'];

          return items.map((item) => CharactersDB.fromJson(item)).toList();
        } else {
          throw Exception("No se encontraron personajes en la respuesta.");
        }
      } else {
        throw Exception(
          "Error al cargar personajes. Código de estado: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error al cargar personajes: $e");
    }
  }
}
