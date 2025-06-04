import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:product_list_app/domain/models/product.dart';
import 'package:product_list_app/services/product_service.dart';

void main() {
  group('ProductService Tests', () {
    final productService = ProductService();

    test('getProducts retorna una lista de productos correctamente', () async {
      // Configurar MockClient
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              "id": 1,
              "title": "Producto 1",
              "price": 10.99,
              "description": "Descripción del producto 1",
              "category": "Categoría 1",
              "image": "imagen1.png",
            },
            {
              "id": 2,
              "title": "Producto 2",
              "price": 15.99,
              "description": "Descripción del producto 2",
              "category": "Categoría 2",
              "image": "imagen2.png",
            },
          ]),
          200,
        );
      });

      productService.httpClient = mockClient;

      // Llamar al método y verificar los resultados
      final products = await productService.getProducts();
      expect(products.length, 2);
      expect(products[0].title, "Producto 1");
    });

    test(
      'getProductDetail retorna los detalles de un producto correctamente',
      () async {
        final mockClient = MockClient((request) async {
          if (request.url.toString() == 'https://fakestoreapi.com/products/1') {
            return http.Response(
              jsonEncode({
                "id": 1,
                "title": "Producto Detalle",
                "price": 10.99,
                "description": "Descripción del producto detalle",
                "category": "Categoría Detalle",
                "image": "imagen_detalle.png",
              }),
              200,
            );
          }
          return http.Response('Not Found', 404);
        });

        final productService = ProductService(client: mockClient);

        final product = await productService.getProductDetail(1);
        expect(product.title, 'Producto Detalle');
      },
    );

    test('addToCart agrega un producto al carrito correctamente', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(
          request.body,
          jsonEncode({
            "userId": 1,
            "products": [
              {
                "id": 1,
                "title": "Producto Carrito",
                "price": 20.99,
                "description": "Descripción del producto carrito",
                "category": "Categoría Carrito",
                "image": "imagenCarrito.png",
              },
            ],
          }),
        );
        return http.Response('', 200);
      });

      productService.httpClient = mockClient;

      final product = Product(
        id: 1,
        title: "Producto Carrito",
        price: 20.99,
        description: "Descripción del producto carrito",
        category: "Categoría Carrito",
        image: "imagenCarrito.png",
      );

      await productService.addToCart(1, product);
    });
  });
}
