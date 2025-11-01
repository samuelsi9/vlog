import 'package:flutter/material.dart';
import 'package:vlog/Models/user_model.dart';
import 'package:vlog/vapp/home.dart';
import 'package:vlog/vapp/widgets/auth/login_page.dart';
import 'package:vlog/Data/apiservices.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  final String? token;

  const ProfileScreen({super.key, required this.user, required this.token});

  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Avatar et infos de base
            const SizedBox(height: 10),
            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(user.email, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),

            // 🔹 Boutons / Sections selon le rôle
            if (user.role == "user") userSection(context),
            if (user.role == "buyer") sellerSection(context),
            if (user.role == "admin") adminSection(context),

            const SizedBox(height: 30),

            // 🔹 Bouton déconnexion
            ElevatedButton.icon(
              onPressed: () async {
                if (token != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                }
                // TODO: add logout logic
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧍 CLIENT
  Widget userSection(BuildContext context) {
    return Column(
      children: [
        profileTile(Icons.shopping_bag, "My Orders"),
        profileTile(Icons.favorite, "Favorites"),
        profileTile(Icons.settings, "Settings"),
      ],
    );
  }

  // 🛍️ VENDEUR
  Widget sellerSection(BuildContext context) {
    return Column(
      children: [
        profileTile(Icons.add_box, "Add Product"),
        profileTile(Icons.store, "My Products"),
        profileTile(Icons.bar_chart, "Sales Analytics"),
      ],
    );
  }

  // 🧑‍💼 ADMIN
  Widget adminSection(BuildContext context) {
    return Column(
      children: [
        profileTile(Icons.people, "All Users"),
        profileTile(Icons.shopping_bag_outlined, "All Products"),
        profileTile(Icons.settings_applications, "Admin Settings"),
      ],
    );
  }

  // Widget réutilisable
  Widget profileTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
