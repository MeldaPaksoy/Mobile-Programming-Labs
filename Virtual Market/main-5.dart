import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroceryApp(),
    );
  }
}

class GroceryApp extends StatefulWidget {
  @override
  _GroceryAppState createState() => _GroceryAppState();
}

class _GroceryAppState extends State<GroceryApp> {
  int currentIndex = 0;
  List<Map<String, dynamic>> cart = [];
  double totalPrice = 0.0;

  List<Map<String, dynamic>> items = [
    {
      'name': 'Avocado',
      'price': 4.00,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlkHQ6NyRZUJ7s-vNsLynqOvBBLteAu6hIXQ&s'
    },
    {
      'name': 'Banana',
      'price': 2.00,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB-Nhn5PA5mzu6wrQkeC7KfTVQwPp8wWkhOw&s'
    },
    {
      'name': 'Chicken',
      'price': 12.00,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrp7wo1YHZwtZ1Z1RMaNl9lHl3YbwLuhmdKQ&s'
    },
    {
      'name': 'Water',
      'price': 1.00,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDDKFKz6y7NZzWGbbMc0ggGAeCqpt5wXN-cQ&s'
    },
  ];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
      totalPrice += item['price'];
    });
  }

  void removeFromCart(Map<String, dynamic> item) {
    setState(() {
      cart.remove(item);
      totalPrice -= item['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0
          ? WelcomeScreen(onGetStarted: () => setState(() => currentIndex = 1))
          : currentIndex == 1
          ? ShopScreen(
        items: items,
        onAddToCart: addToCart,
        onCartPressed: () => setState(() => currentIndex = 2),
      )
          : CartScreen(
        cart: cart,
        totalPrice: totalPrice,
        onRemove: removeFromCart,
        onBack: () => setState(() => currentIndex = 1),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;

  const WelcomeScreen({required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlkHQ6NyRZUJ7s-vNsLynqOvBBLteAu6hIXQ&s'),
          const SizedBox(height: 20),
          Text(
            'We deliver groceries at your doorstep',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Fresh items every day',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: onGetStarted,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onAddToCart;
  final VoidCallback onCartPressed;

  const ShopScreen({
    required this.items,
    required this.onAddToCart,
    required this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Sydney, Australia',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.account_circle, size: 32),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Let\'s order fresh items for you',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              'Fresh Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8, // Adjust the ratio to shape the cards
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final colors = [
                    Colors.green.shade100,
                    Colors.yellow.shade100,
                    Colors.brown.shade100,
                    Colors.blue.shade100
                  ];
                  final buttonColors = [
                    Colors.green,
                    Colors.yellow,
                    Colors.brown,
                    Colors.blue,
                  ];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: colors[index % colors.length],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Image.network(
                              item['imageUrl'],
                              fit: BoxFit.contain,
                              height: 80,
                            ),
                          ),
                          Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => onAddToCart(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColors[index % buttonColors.length],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(double.infinity, 36),
                            ),
                            child: Text(
                              '\$${item['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCartPressed,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final double totalPrice;
  final Function(Map<String, dynamic>) onRemove;
  final VoidCallback onBack;

  const CartScreen({
    required this.cart,
    required this.totalPrice,
    required this.onRemove,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(item['imageUrl'], width: 50, height: 50),
                    title: Text(item['name']),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => onRemove(item),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.green,
              padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8), // Add space between the total label and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center, // Vertically center the button
                      children: [
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),



            ),
          ),
        ],
      ),

    );
  }
}
