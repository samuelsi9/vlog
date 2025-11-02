import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlog/presentation/auth/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedCurrency = 'USD';
  String _selectedLanguage = 'English';
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _orderUpdates = true;
  bool _promotionalUpdates = false;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'];
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('currency') ?? 'USD';
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _pushNotifications = prefs.getBool('push_notifications') ?? true;
      _emailNotifications = prefs.getBool('email_notifications') ?? true;
      _orderUpdates = prefs.getBool('order_updates') ?? true;
      _promotionalUpdates = prefs.getBool('promotional_updates') ?? false;
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  void _showShippingAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Street Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "City",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "State",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "ZIP Code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Country",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Shipping address saved!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Save Address",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Privacy Policy"),
        content: const SingleChildScrollView(
          child: Text(
            "Privacy Policy\n\n"
            "Last Updated: January 2024\n\n"
            "We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and safeguard your information when you use our app.\n\n"
            "Information We Collect:\n"
            "- Personal information (name, email, address)\n"
            "- Payment information\n"
            "- Device information\n"
            "- Usage data\n\n"
            "How We Use Your Information:\n"
            "- To process your orders\n"
            "- To improve our services\n"
            "- To send you updates (with your consent)\n"
            "- To comply with legal obligations\n\n"
            "Data Security:\n"
            "We implement appropriate security measures to protect your personal data.\n\n"
            "Your Rights:\n"
            "You have the right to access, update, or delete your personal information at any time.",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showLegalInformation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Legal Information"),
        content: const SingleChildScrollView(
          child: Text(
            "Legal Information\n\n"
            "Terms of Service\n\n"
            "By using this app, you agree to the following terms:\n"
            "- You must be at least 18 years old to make purchases\n"
            "- All products are subject to availability\n"
            "- Prices are subject to change without notice\n"
            "- We reserve the right to refuse service\n\n"
            "Refund Policy:\n"
            "Items can be returned within 30 days of purchase with receipt.\n\n"
            "Warranty:\n"
            "All products come with manufacturer's warranty.\n\n"
            "Limitation of Liability:\n"
            "Our liability is limited to the purchase price of products.",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              }
            },
            child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // Shipping Address
          _buildSection(
            title: "Shipping",
            children: [
              _buildTile(
                icon: Icons.location_on,
                title: "Shipping Address",
                subtitle: "Manage your delivery address",
                onTap: _showShippingAddress,
              ),
            ],
          ),

          // Currency & Language
          _buildSection(
            title: "Preferences",
            children: [
              _buildTile(
                icon: Icons.attach_money,
                title: "Currency",
                subtitle: _selectedCurrency,
                trailing: DropdownButton<String>(
                  value: _selectedCurrency,
                  underline: const SizedBox(),
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedCurrency = value);
                      _saveSetting('currency', value);
                    }
                  },
                ),
              ),
              _buildTile(
                icon: Icons.language,
                title: "Language",
                subtitle: _selectedLanguage,
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  underline: const SizedBox(),
                  items: _languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLanguage = value);
                      _saveSetting('language', value);
                    }
                  },
                ),
              ),
            ],
          ),

          // Notifications
          _buildSection(
            title: "Notifications",
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_active),
                title: const Text("Push Notifications"),
                subtitle: const Text("Receive push notifications"),
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() => _pushNotifications = value);
                  _saveSetting('push_notifications', value);
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.email),
                title: const Text("Email Notifications"),
                subtitle: const Text("Receive email updates"),
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() => _emailNotifications = value);
                  _saveSetting('email_notifications', value);
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.shopping_bag),
                title: const Text("Order Updates"),
                subtitle: const Text("Get notified about your orders"),
                value: _orderUpdates,
                onChanged: (value) {
                  setState(() => _orderUpdates = value);
                  _saveSetting('order_updates', value);
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.local_offer),
                title: const Text("Promotional Updates"),
                subtitle: const Text("Receive offers and discounts"),
                value: _promotionalUpdates,
                onChanged: (value) {
                  setState(() => _promotionalUpdates = value);
                  _saveSetting('promotional_updates', value);
                },
              ),
            ],
          ),

          // Legal & About
          _buildSection(
            title: "Legal & About",
            children: [
              _buildTile(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: _showPrivacyPolicy,
              ),
              _buildTile(
                icon: Icons.description,
                title: "Legal Information",
                onTap: _showLegalInformation,
              ),
              _buildTile(
                icon: Icons.info,
                title: "App Version",
                subtitle: "1.0.0",
                onTap: () {},
              ),
            ],
          ),

          // Sign Out
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: children),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
