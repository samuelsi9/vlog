import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  // In a real app, this would be driven by backend status
  int _currentStep = 0; // 0..4

  final List<String> _steps = const [
    'Order placed',
    'Order confirmed',
    'Preparing order',
    'Order shipped',
    'Order delivered',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Tracking')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Progress',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Stepper(
                  currentStep: _currentStep,
                  controlsBuilder: (context, details) {
                    return const SizedBox.shrink();
                  },
                  steps: List.generate(_steps.length, (index) {
                    return Step(
                      title: Text(_steps[index]),
                      subtitle: Text(
                        index == 0
                            ? 'We received your order'
                            : index == 1
                            ? 'Seller confirmed your order'
                            : index == 2
                            ? 'Your order is being prepared'
                            : index == 3
                            ? 'Your order is on the way'
                            : 'Your order has been delivered',
                      ),
                      isActive: _currentStep >= index,
                      state: _currentStep > index
                          ? StepState.complete
                          : _currentStep == index
                          ? StepState.editing
                          : StepState.indexed,
                      content: const SizedBox.shrink(),
                    );
                  }),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentStep <= 0
                          ? null
                          : () => setState(() => _currentStep -= 1),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentStep >= _steps.length - 1
                          ? null
                          : () => setState(() => _currentStep += 1),
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
