import 'package:flutter/material.dart';
import 'package:product_list_app/cart/cart.dart';
import 'package:product_list_app/models/product.dart';
import 'package:product_list_app/services/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final ProductService productService = ProductService();
  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              'Precio:	\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await productService.addToCart(1, product);
                  Cart.add(product);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} agregado al carrito'),
                    ),
                  );
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar al carrito: $e')),
                  );
                }
              },
              child: Text('Agregar	al	carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
