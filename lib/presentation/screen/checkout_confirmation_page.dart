import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlog/Utils/cart_service.dart';

class CheckoutConfirmationPage extends StatefulWidget {
  const CheckoutConfirmationPage({super.key});

  @override
  State<CheckoutConfirmationPage> createState() =>
      _CheckoutConfirmationPageState();
}

class _CheckoutConfirmationPageState extends State<CheckoutConfirmationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _placeOrder(BuildContext context) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Order placed'),
        content: const Text('Waiting for the seller confirmation.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Optionally clear cart after placing order
              Provider.of<CartService>(context, listen: false).clearCart();
              Navigator.of(context).pushReplacementNamed('/order-tracking');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Confirmation')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Items Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (cart.cartItems.isEmpty)
                const Text('Your cart is empty.')
              else
                ...cart.cartItems.map(
                  (ci) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(ci.item.name),
                    subtitle: Text('Qty: ${ci.quantity}'),
                    trailing: Text('\$${ci.totalPrice.toStringAsFixed(2)}'),
                  ),
                ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Shipping Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (v) => (v == null || v.trim().length < 6)
                    ? 'Enter valid phone'
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),

              const SizedBox(height: 24),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RadioListTile<String>(
                value: 'cod',
                groupValue: 'cod',
                onChanged: (_) {},
                title: const Text('Cash on Delivery'),
                subtitle: const Text(
                  'Pay in cash when your order is delivered',
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Order notes (optional)',
                ),
                minLines: 2,
                maxLines: 4,
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: cart.cartItems.isEmpty
                      ? null
                      : () => _placeOrder(context),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
