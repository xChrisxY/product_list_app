import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_list_app/models/product.dart';

class ProductService {
  final String url = 'https://fakestoreapi.com/products';
  final String cartUrl = 'https://fakestoreapi.com/carts';

  Future<List<Product>> getProducts() async {
    final responseService = await http.get(Uri.parse(url));

    if (responseService.statusCode == 200) {
      List<dynamic> jsonList = json.decode(responseService.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al consumir');
    }
  }

  Future<Product> getProductDetail(int id) async {
    final responseService = await http.get(Uri.parse('$url/$id'));

    if (responseService.statusCode == 200) {
      return Product.fromJson(json.decode(responseService.body));
    } else {
      throw Exception('Error al obtener detalles del producto');
    }
  }

  Future<void> addToCart(int userId, Product product) async {
    final response = await http.post(
      Uri.parse(cartUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "userId": userId,
        "products": [
          {
            "id": product.id,
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "category": product.category,
            "image": product.image,
          },
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar al carrito');
    }
  }
}
