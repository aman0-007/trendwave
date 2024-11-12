import 'package:flutter/material.dart';

class ProductCardRow extends StatefulWidget {
  @override
  _ProductCardRowState createState() => _ProductCardRowState();
}

class _ProductCardRowState extends State<ProductCardRow> with TickerProviderStateMixin {
  // Hardcoded list of products with network images and names
  final List<Map<String, dynamic>> products = [
    {'image': 'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?q=80&w=1778&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Product 1'},
    {'image': 'https://media.istockphoto.com/id/675623820/photo/black-leather-crossbody-bag-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=3Ir3h3dkTtbMZ2H7k_z2OxsPRMrt6SI85SpaHYXW82I=', 'name': 'Product 2'},
    {'image': 'https://plus.unsplash.com/premium_photo-1664391658474-c5509d4fc003?q=80&w=1960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Product 3'},
    {'image': 'https://plus.unsplash.com/premium_photo-1672829371769-bcff266023a4?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Product 4'},
    {'image': 'https://plus.unsplash.com/premium_photo-1693222144355-82ccb4cfc774?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Product 5'},
  ];

  // List to keep track of liked products
  List<bool> isLiked = [false, false, false, false, false]; // Now accounting for 5 products

  // Animation controllers for the zoom effect on like icon
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      products.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _animations = List.generate(
      products.length,
          (index) => Tween<double>(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  // This function will be triggered when the like icon is pressed
  void onLikePressed(int index) {
    setState(() {
      if (!isLiked[index]) {
        // Trigger animation only when the product is being liked (not disliked)
        _controllers[index].forward().then((_) {
          _controllers[index].reverse(); // Reverse the animation after completion
        });
      }
      isLiked[index] = !isLiked[index]; // Toggle the like status
    });
  }

  @override
  void dispose() {
    // Dispose all animation controllers to avoid memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading above the product row
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Featured Products', // Heading Text
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Reduced the font size for heading
            ),
          ),
        ),
        // Display 5 products
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < products.length; i++) ...[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.primary, // Add a border with the primary color
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white, // White background for the card
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // Network image for the product with padding around it
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150, // Set a fixed size for the image
                              height: 150, // Make the image square
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12), // Keep the container rounded
                              ),
                              child: Image.network(
                                products[i]['image'], // Use your network image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Like icon on the top right corner
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                onLikePressed(i); // Trigger callback
                              },
                              child: ScaleTransition(
                                scale: _animations[i],
                                child: Icon(
                                  isLiked[i] ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked[i] ? Colors.red : theme.colorScheme.secondary,
                                  size: 24, // Increased the size of the like icon
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Product name with an arrow icon placed below the image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          children: [
                            Text(
                              products[i]['name'],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // Reduced the font size for the product name
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              color: theme.colorScheme.onSurface,
                              size: 16, // Slightly smaller arrow size
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // Add a circle button at the end for "View All"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Action for "View All" button (e.g., navigate to another screen)
                  },
                  child: Column(
                    children: [
                      // Circle with arrow
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary, // Circle color
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 28, // Adjust the size of the arrow
                          ),
                        ),
                      ),
                      // Text below the circle
                      const SizedBox(height: 8),
                      Text(
                        'View All',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Font size for "View All"
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
