import 'package:flutter/material.dart';
import 'models/Product.dart';
import 'models/CartItem.dart';
import 'HomeScreen.dart';
import 'ProductListScreen.dart';
import 'ProductDetailScreen.dart';
import 'Cart.dart';
import 'ProfileScreen.dart';


// Main App with State Management using setState
class HamiApp extends StatefulWidget {
  @override
  _HamiAppState createState() => _HamiAppState();
}

class _HamiAppState extends State<HamiApp> {
  int _currentIndex = 0;
  List<CartItem> _cartItems = [];

  // Dummy Data - 6 Fruits and Vegetables
  final List<Product> _products = [
    Product(
      name: 'Tufaax',
      price: 2.5,
      image: '🍎',
      description: 'Tufaax cusub oo macaan, laga soo raray beeraha Hargaysa. Waxay leedahay vitamins iyo fiber badan.',
    ),
    Product(
      name: 'Moos',
      price: 1.8,
      image: '🍌',
      description: 'Moos khafiif ah oo ka yimid Kenya. Ku fiirso inaad heli doonto potassium iyo magnesium.',
    ),
    Product(
      name: 'Baranbur',
      price: 3.2,
      image: '🍓',
      description: 'Baranbur cusub oo macaan, laga soo raray Ethiopia. Waxay leedahay antioxidants badan.',
    ),
    Product(
      name: 'Bustaanii',
      price: 2.0,
      image: '🥦',
      description: 'Bustaanii cusub oo ka yimid beeraha Somaliland. Ku fiirso inaad heli doonto vitamin C iyo K.',
    ),
    Product(
      name: 'Baradho',
      price: 1.5,
      image: '🍅',
      description: 'Baradho macaan oo cusub. Waxaa lagu wadaa inuu yahay mid ka mid ah khudaarta ugu faa iidaysiga badanimada.',
    ),
    Product(
      name: 'Qaraha',
      price: 2.8,
      image: '🥒',
      description: 'Qaraha cusub oo qurux badan. Waxaa lagu wadaa inuu yahay mid ka mid ah khudaarta ugu faa iidaysiga badanimada.',
    ),
  ];

  // Cart Methods
  void _addToCart(Product product) {
    setState(() {
      final existingIndex = _cartItems.indexWhere((item) => item.product.name == product.name);
      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity++;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.removeWhere((item) => item.product.name == product.name);
    });
  }

  void _increaseQuantity(Product product) {
    setState(() {
      final item = _cartItems.firstWhere((item) => item.product.name == product.name);
      item.quantity++;
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      final item = _cartItems.firstWhere((item) => item.product.name == product.name);
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _cartItems.removeWhere((cartItem) => cartItem.product.name == product.name);
      }
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  bool _isInCart(Product product) {
    return _cartItems.any((item) => item.product.name == product.name);
  }

  int get _totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get _totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Hami MiniMarket'),
        backgroundColor: Color(0xFF2E7D32),
        // centerTitle: true,
        elevation: 4,
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (_totalItems > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        _totalItems.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onProductsTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                  products: _products,
                  isInCart: _isInCart,
                  onProductTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                          isInCart: _isInCart(product),
                          onAddToCart: () => _addToCart(product),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      case 1:
        return CartScreen(
          cartItems: _cartItems,
          totalPrice: _totalPrice,
          onIncreaseQuantity: _increaseQuantity,
          onDecreaseQuantity: _decreaseQuantity,
          onRemoveFromCart: _removeFromCart,
          onClearCart: _clearCart,
          onBrowseProducts: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        );
      case 2:
        return ProfileScreen();
      default:
        return HomeScreen(onProductsTap: () {});
    }
  }
}
