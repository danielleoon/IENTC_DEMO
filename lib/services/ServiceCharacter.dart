import 'dart:convert';
import 'package:ientc_jdls/class/originPlanets.dart';
import 'package:ientc_jdls/class/transformations.dart';
import 'package:http/http.dart' as http;

class ServiceCharacter {
  static const String _baseUrl = "https://dragonball-api.com/api/characters";

  static Future<Map<String, dynamic>> fetchCharacterExtras(
      int characterId) async {
    try {
      final url = Uri.parse("$_baseUrl/$characterId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        final originPlanet = jsonResponse['originPlanet'] != null
            ? OriginPlanet.fromJson(jsonResponse['originPlanet'])
            : null;

        final transformations = jsonResponse['transformations'] != null
            ? (jsonResponse['transformations'] as List)
                .map((item) => Transformation.fromJson(item))
                .toList()
            : [];

        return {
          'originPlanet': originPlanet,
          'transformations': transformations,
        };
      } else {
        throw Exception(
          "Error al cargar los datos del personaje. Código de estado: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error al cargar los datos del personaje: $e");
    }
  }
}
