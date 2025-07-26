import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?page=1'),
        headers: {
          'x-api-key': 'reqres-free-v1', // Cabeçalho necessário
        },
      );

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List usersJson = jsonData['data'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Erro ao carregar usuários: $e');
    }
  }
}
