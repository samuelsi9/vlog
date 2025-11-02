import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlog/Models/user_model.dart';
import 'package:vlog/Models/model.dart';
import 'package:vlog/Utils/cart_service.dart';
import 'package:vlog/presentation/screen/cart_page.dart';
import 'package:vlog/presentation/screen/detail_screen.dart';
import 'package:vlog/presentation/screen/profile_settings_page.dart';
import 'package:vlog/presentation/screen/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

// ---------- MAIN SCREEN ----------
class ProfileScreen extends StatefulWidget {
  final String? token;
  final UserModel? user;

  const ProfileScreen({super.key, this.token, this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Use items from the existing itemModel list
  List<itemModel> get recentItems => itemC.take(4).toList();

  String? _localProfileName;
  String? _localProfileImagePath;

  @override
  void initState() {
    super.initState();
    _loadLocalProfile();
  }

  Future<void> _loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _localProfileName = prefs.getString('profile_name');
      _localProfileImagePath = prefs.getString('profile_image_path');
    });
  }

  Future<void> _saveProfile(String name, String? imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', name);
    if (imagePath != null) {
      await prefs.setString('profile_image_path', imagePath);
    }
    setState(() {
      _localProfileName = name;
      _localProfileImagePath = imagePath;
    });
  }

  String get _displayName {
    if (_localProfileName != null && _localProfileName!.isNotEmpty) {
      return _localProfileName!;
    }
    return widget.user?.name ?? "Guest User";
  }

  ImageProvider get _profileImage {
    // Priority: local image path > user model image > default asset
    if (_localProfileImagePath != null && _localProfileImagePath!.isNotEmpty) {
      try {
        return FileImage(File(_localProfileImagePath!));
      } catch (e) {
        // If file doesn't exist, fall back to default
        return const AssetImage('assets/man.jpg');
      }
    }
    if (widget.user?.image != null &&
        widget.user!.image.isNotEmpty &&
        !widget.user!.image.startsWith('assets/')) {
      return NetworkImage(widget.user!.image);
    }
    return const AssetImage('assets/man.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingsPage(
                          currentName: _displayName,
                          currentImage:
                              _localProfileImagePath ?? widget.user?.image,
                          onSave: _saveProfile,
                        ),
                      ),
                    );
                    // Reload profile after returning
                    await _loadLocalProfile();
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: _profileImage,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.user?.role ?? "User",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                Consumer<CartService>(
                  builder: (context, cartService, child) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartPage(),
                              ),
                            );
                          },
                        ),
                        if (cartService.itemCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${cartService.itemCount}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Recently Viewed",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = recentItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(ecom: item),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            item.image,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            item.name,
                            style: const TextStyle(fontSize: 13),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "\$${item.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<CartService>(
                            builder: (context, cartService, child) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartService.addToCart(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${item.name} added to cart",
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text("Add to Cart"),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
