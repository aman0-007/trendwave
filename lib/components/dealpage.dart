import 'package:flutter/material.dart';

class DealsForYou extends StatelessWidget {
  const DealsForYou({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded list of products with network images and names
    final List<Map<String, dynamic>> products = [
      {'image': 'https://media.istockphoto.com/id/675623820/photo/black-leather-crossbody-bag-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=3Ir3h3dkTtbMZ2H7k_z2OxsPRMrt6SI85SpaHYXW82I='},
      {'image': 'https://plus.unsplash.com/premium_photo-1664391658474-c5509d4fc003?q=80&w=1960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
      {'image': 'https://plus.unsplash.com/premium_photo-1672829371769-bcff266023a4?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
      {'image': 'https://plus.unsplash.com/premium_photo-1693222144355-82ccb4cfc774?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deals for You',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10), // Space above the grid
        // Displaying products in a grid format
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16, // Reduced space between rows
            crossAxisSpacing: 16, // Reduced space between columns
            childAspectRatio: 0.99, // Adjusted for better aspect ratio
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                // Product container with image and padding
                Container(
                  padding: const EdgeInsets.all(8), // Padding around the image
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color as white
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      products[index]['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150, // Adjust image size
                    ),
                  ),
                ),
                const SizedBox(height: 4), // Reduced space between image and text
                // Text below the product container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0707), // Red background
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: Text(
                          '10% OFF',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Limited Time Deal',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF0707), // Red color
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
