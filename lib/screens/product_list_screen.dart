import 'package:flutter/material.dart';
import 'package:product_list_app/models/product.dart';
import 'package:product_list_app/screens/cart_screen.dart';
import 'package:product_list_app/screens/product_detail_screen.dart';
import 'package:product_list_app/services/product_service.dart';

class ProductListScreen extends StatelessWidget {
  final productService = ProductService();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),

      body: FutureBuilder<List<Product>>(
        future: productService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                onTap: () async {
                  try {
                    final productDetail = await productService.getProductDetail(
                      product.id,
                    );
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ProductDetailScreen(product: productDetail),
                      ),
                    );
                  } catch (error) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al cargar detalles del producto'),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
