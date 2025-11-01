import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:vlog/vapp/home.dart';
import 'package:vlog/vapp/widgets/auth/login_page.dart';
import 'package:vlog/vapp/widgets/auth/reset_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  String? _initialLink;
  bool _initialized = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    try {
      _initialLink = await getInitialLink();
      if (_initialLink != null) {
        _handleLink(_initialLink!);
      }
    } catch (_) {}

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        _handleLink(link);
      }
    }, onError: (err) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    setState(() {
      _isAuthenticated = token != null && token.isNotEmpty;
      _initialized = true;
    });
  }

  void _handleLink(String link) {
    // Supported:
    // - OAuth: vlog://auth/callback?token=...&provider=google|facebook
    // - Reset: vlog://auth/reset?resettoken=...
    final uri = Uri.parse(link);
    final host = uri.host; // 'auth'
    final path = uri.path; // '/callback' or '/reset'

    if (host == 'auth' && path == '/callback') {
      final token = uri.queryParameters['token'];
      if (token != null && token.isNotEmpty) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainScreen(token: null)),
          (route) => false,
        );
      }
      return;
    }

    if (host == 'auth' && path == '/reset') {
      final resetToken = uri.queryParameters['resettoken'];
      if (resetToken != null && resetToken.isNotEmpty) {
        if (!mounted) return;
        // Navigate to reset password screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ResetPasswordPage(resetToken: resetToken),
          ),
        );
      }
      return;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(
        token: null,
      ), //_isAuthenticated ? MainScreen(token: null) : LoginPage(),
    );
  }
}
