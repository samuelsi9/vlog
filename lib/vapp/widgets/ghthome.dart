import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile + Cart Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const ProfileScreen(),
    );
  }
}

// ---------- MODEL ----------
class Product {
  final String image;
  final String title;
  final double price;
  final double oldPrice;

  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
  });
}

// ---------- MAIN SCREEN ----------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    Text("home"),
    Text("search"),
    Text("chat "),
    Text('Wishlist'),
    Text("Inbox"),
    Text("Profile"),
  ];
  final List<Product> products = [
    Product(
      image: 'assets/jacket1.png',
      title: 'Unisex Green Leather Jacket with Zipper and...',
      price: 299.99,
      oldPrice: 399.99,
    ),
    Product(
      image: 'assets/jacket2.png',
      title: 'Unisex Blue Denim Jacket with Button...',
      price: 279.99,
      oldPrice: 359.99,
    ),
    Product(
      image: 'assets/jacket3.png',
      title: 'Yellow Winter Jacket with Hood and Zip...',
      price: 199.99,
      oldPrice: 299.99,
    ),
    Product(
      image: 'assets/shoes.png',
      title: 'Nike Air Max - Green Edition',
      price: 149.99,
      oldPrice: 199.99,
    ),
  ];

  final List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.title} added to cart"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openCart() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "🛒 Your Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              if (cart.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Your cart is empty."),
                )
              else
                ...cart.map(
                  (item) => ListTile(
                    leading: Image.asset(item.image, height: 40),
                    title: Text(item.title, maxLines: 1),
                    subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          cart.remove(item);
                        });
                        Navigator.pop(context);
                        openCart();
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              if (cart.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.payment),
                  label: const Text("Checkout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {});
          selectedIndex = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openCart,
        backgroundColor: Colors.amber,
        label: Text("Cart (${cart.length})"),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
