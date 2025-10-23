import 'package:flutter/material.dart';
import 'models/Product.dart';
import 'models/CartItem.dart';


// Cart Screen
class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalPrice;
  final Function(Product) onIncreaseQuantity;
  final Function(Product) onDecreaseQuantity;
  final Function(Product) onRemoveFromCart;
  final VoidCallback onClearCart;
  final VoidCallback onBrowseProducts;

  CartScreen({
    required this.cartItems,
    required this.totalPrice,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveFromCart,
    required this.onClearCart,
    required this.onBrowseProducts,
  });

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
              SizedBox(height: 20),
              Text(
                'Dalabkaaga waa madhan yahay',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Text(
                'Ku dar alaab si aad u dukaameysato',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onBrowseProducts,
                child: Text('Daawo Alaabta',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2E7D32)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dalabkaaga (${cartItems.length},)',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF2E7D32),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep,color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Dalabkaaga oo madhan'),
                  content: Text('Ma hubtaa inaad rabto inaad ka saarto dhammaan alaabta?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        onClearCart();
                        Navigator.pop(context);
                      },
                      child: Text('Haa, Madhan', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
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
                          item.product.image,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    title: Text(
                      item.product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('\$${item.product.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () => onDecreaseQuantity(item.product),
                        ),
                        Text(
                          '${item.quantity}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline, color: Color(0xFF2E7D32)),
                          onPressed: () => onIncreaseQuantity(item.product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.grey),
                          onPressed: () => onRemoveFromCart(item.product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wadarta',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Waad ku guulaysatay dalabkaaga! 🎉'),
                          backgroundColor: Color(0xFF2E7D32),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Text(
                      'Samee Dalab',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}