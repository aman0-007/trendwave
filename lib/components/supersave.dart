import 'package:flutter/material.dart';

class SupersavePage extends StatefulWidget {
  const SupersavePage({super.key});

  @override
  _SupersavePageState createState() => _SupersavePageState();
}

class _SupersavePageState extends State<SupersavePage> {
  int _currentIndex = 0;

  // Using the provided list of image URLs
  final List<Map<String, dynamic>> products = [
    {'image': 'https://media.istockphoto.com/id/675623820/photo/black-leather-crossbody-bag-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=3Ir3h3dkTtbMZ2H7k_z2OxsPRMrt6SI85SpaHYXW82I='},
    {'image': 'https://plus.unsplash.com/premium_photo-1664391658474-c5509d4fc003?q=80&w=1960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
    {'image': 'https://plus.unsplash.com/premium_photo-1672829371769-bcff266023a4?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
    {'image': 'https://plus.unsplash.com/premium_photo-1693222144355-82ccb4cfc774?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
  ];

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  void _startImageRotation() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % products.length;
      });
      _startImageRotation(); // Recurse to keep rotating the images
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Buy More, Save More | Up to ₹90 Cashback',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 19
            ),
          ),
        ),
        const SizedBox(height: 2), // Space before the image container

        // Image carousel with fade-in and fade-out effect
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Apply the same padding as the title
          child: Container(
            width: double.infinity, // Full width
            height: 300, // Specific height for the image container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).scaffoldBackgroundColor, // Background color based on theme
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1), // Duration of fade effect
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: ClipRRect(
                    key: ValueKey<int>(_currentIndex), // Unique key for each image
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      products[_currentIndex]['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Text on top of the image
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    'Save Big with Supersave!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
