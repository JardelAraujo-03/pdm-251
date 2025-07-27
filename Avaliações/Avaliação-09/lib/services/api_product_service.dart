import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiProductService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.get(url);

      print('STATUS CODE: ${response.statusCode}');
      // Trunca a resposta para evitar RangeError
      final truncated =
          response.body.substring(0, min(200, response.body.length));
      print('BODY (truncado): $truncated');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final products =
            jsonData.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        throw Exception('Erro ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      print('Falha na requisição: $e');
      throw Exception('Falha na requisição: $e');
    }
  }
}
