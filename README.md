# VLog - E-Commerce Shopping App

A modern Flutter-based e-commerce application similar to Walmart, designed for seamless online shopping experiences. Users can browse products, add items to cart, place orders, and manage their accounts with ease.

## 📱 Features

### 🛍️ Shopping Experience
- **Product Browsing**: Browse through various product categories
- **Search Functionality**: Search for products by name or description
- **Product Details**: View detailed product information, ratings, and reviews
- **Shopping Cart**: Add/remove items, adjust quantities
- **Wishlist**: Save favorite products for later
- **Minimum Order**: $50 minimum order requirement for checkout

### 🔐 Authentication
- **Email/Password**: Traditional email and password registration and login
- **Google Sign-In**: Quick authentication using Google account
- **Apple Sign-In**: Seamless authentication for iOS users (requires Apple Developer account)
- **Account Management**: Profile settings, account deletion

### 💳 Order Management
- **Checkout Process**: Secure checkout with delivery details
- **Order Tracking**: Track your orders in real-time
- **Order History**: View past orders
- **Order Confirmation**: Beautiful success confirmation after order placement

### 💬 Customer Support
- **FAQ Section**: Frequently asked questions with answers
- **Question Submission**: Submit questions to customer support team
- **Category-based Support**: Questions organized by categories (Orders, Shipping, Returns, Products, Payment, Account)

### 🎨 User Interface
- **Modern Design**: Clean and intuitive UI with smooth animations
- **Responsive Layout**: Optimized for different screen sizes
- **Dark Mode Ready**: UI components support theming

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account (for Google/Apple authentication)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd vlog
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase** (for Google/Apple authentication)
   
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase
   flutterfire configure
   ```

   Follow the prompts to:
   - Select your Firebase project
   - Choose platforms (iOS, Android, Web)
   - Firebase will generate `firebase_options.dart`

4. **Initialize Firebase in main.dart**

   After running `flutterfire configure`, uncomment the Firebase initialization in `lib/main.dart`:
   
   ```dart
   import 'package:firebase_core/firebase_core.dart';
   import 'firebase_options.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     runApp(const MyApp());
   }
   ```

5. **Configure Google Sign-In**

   - **Android**: Add your app's SHA-1 fingerprint to Firebase Console
     ```bash
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     ```
   
   - **iOS**: Add your iOS bundle ID in Firebase Console and download `GoogleService-Info.plist`
   
   - **Web**: Add your domain to Firebase Console authorized domains

6. **Configure Apple Sign-In** (iOS only)

   - Enable Sign in with Apple in your Apple Developer account
   - Configure Apple Sign-In in Firebase Console
   - Add the Sign in with Apple capability in Xcode

## 📦 Dependencies

### Core Dependencies
- `flutter`: Flutter SDK
- `provider: ^6.0.0`: State management
- `shared_preferences: ^2.3.2`: Local data storage

### Authentication
- `firebase_core: ^3.6.0`: Firebase core functionality
- `firebase_auth: ^5.3.1`: Firebase authentication
- `google_sign_in: ^6.2.1`: Google Sign-In integration
- `sign_in_with_apple: ^6.1.1`: Apple Sign-In integration

### UI & Utilities
- `dio: ^5.9.0`: HTTP client
- `url_launcher: ^6.3.1`: Launch URLs
- `uni_links: ^0.5.1`: Deep linking
- `image_picker: ^1.0.7`: Image selection
- `shimmer: ^3.0.0`: Loading animations

## 🏃 Running the App

### Development Mode
```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d android
flutter run -d ios
flutter run -d web
```

### Build for Production

**Android**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## 📁 Project Structure

```
lib/
├── Data/
│   └── apiservices.dart          # API services
├── Models/
│   ├── model.dart                # Product models
│   ├── category_model.dart       # Category models
│   ├── order_model.dart          # Order models
│   └── user_model.dart           # User models
├── presentation/
│   ├── auth/
│   │   ├── login_page.dart       # Login screen
│   │   ├── register_page.dart    # Registration screen
│   │   ├── forgot_password_page.dart
│   │   └── reset_password_page.dart
│   ├── screen/
│   │   ├── cart_page.dart        # Shopping cart
│   │   ├── checkout_confirmation_page.dart
│   │   ├── detail_screen.dart    # Product details
│   │   ├── search_page.dart      # Search functionality
│   │   ├── wishlist_page.dart    # Wishlist
│   │   ├── support_qa_page.dart  # Support & Q&A
│   │   ├── profilepage.dart      # User profile
│   │   └── settings_page.dart    # App settings
│   ├── home.dart                 # Main navigation
│   ├── realhome.dart             # Home screen
│   └── curatedItems.dart         # Product cards
└── Utils/
    ├── cart_service.dart         # Cart state management
    ├── wishlist_service.dart     # Wishlist management
    └── delivery_tracking_service.dart
```

## ✨ Key Features Details

### Minimum Order Amount
- Users must have at least $50 in their cart (including delivery fees) to proceed to checkout
- Visual indicators show remaining amount needed
- Checkout button is disabled until minimum is met

### Account Deletion
- Users can delete their account from Settings
- Two-step confirmation process for security
- All user data is permanently deleted
- Includes: profile, orders, addresses, wishlist

### Order Confirmation
- Beautiful success dialog after order placement
- Shows order total and confirmation details
- Email confirmation notification
- Automatic cart clearing after successful order

## 🔧 Configuration

### Environment Variables
- Firebase configuration is handled through `firebase_options.dart` (generated by FlutterFire CLI)

### App Constants
- Minimum order amount: $50.00 (defined in cart and checkout pages)
- Delivery fee: $2.99 (configurable in cart service)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

Your Name

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for authentication services
- All package contributors

## 📞 Support

For support, email your-email@example.com or create an issue in the repository.

## 🔮 Future Enhancements

- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Product reviews and ratings system
- [ ] Social media sharing
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Advanced search filters
- [ ] Product recommendations
- [ ] Live chat support
- [ ] Order cancellation and returns

---

**Note**: Make sure to configure Firebase properly before using Google/Apple authentication features. The app will function with email/password authentication without Firebase, but social login requires Firebase setup.
