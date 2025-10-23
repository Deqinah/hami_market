import 'package:flutter/material.dart';
import 'models/Product.dart';
import 'models/CartItem.dart';


// Product List Screen using ListView
class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final bool Function(Product) isInCart;
  final Function(Product) onProductTap;

  ProductListScreen({
    required this.products,
    required this.isInCart,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alaabta'),
        backgroundColor: Color(0xFF2E7D32),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    product.image,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: isInCart(product)
                  ? Icon(Icons.check_circle, color: Color(0xFF2E7D32))
                  : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () => onProductTap(product),
            ),
          );
        },
      ),
    );
  }
}
