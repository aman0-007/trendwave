import 'package:flutter/material.dart';

class TopPicksForYou extends StatelessWidget {
  const TopPicksForYou({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded list of products with network images and names
    final List<Map<String, dynamic>> products = [
      {'image': 'https://media.istockphoto.com/id/675623820/photo/black-leather-crossbody-bag-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=3Ir3h3dkTtbMZ2H7k_z2OxsPRMrt6SI85SpaHYXW82I=', 'name': 'Leather Crossbody Bag', 'price': '₹1500'},
      {'image': 'https://plus.unsplash.com/premium_photo-1664391658474-c5509d4fc003?q=80&w=1960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Handmade Bracelet', 'price': '₹500'},
      {'image': 'https://plus.unsplash.com/premium_photo-1672829371769-bcff266023a4?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Canvas Sneakers', 'price': '₹2000'},
      {'image': 'https://plus.unsplash.com/premium_photo-1693222144355-82ccb4cfc774?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'name': 'Wooden Desk Lamp', 'price': '₹1200'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Picks for You', // Changed title here
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
            childAspectRatio: 0.94, // Adjusted for better aspect ratio
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                // Product container with greyish background
                Container(
                  padding: const EdgeInsets.all(1), // Padding around the image
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Greyish background color
                    borderRadius: BorderRadius.circular(12),
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
                      // Expanded image fully occupying space
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          products[index]['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150, // Adjust image size
                        ),
                      ),
                      // Discount Badge at the top left corner
                      Positioned(
                        top: 7,
                        left: 7,
                        child: Container(
                          padding: const EdgeInsets.all(4), // Adjust padding to make the circle fit well
                          decoration: BoxDecoration(
                            color: Colors.red, // Red color for the discount badge
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '77% ',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  'OFF',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2), // Space between product container and text
                // Product name and price
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index]['name'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          products[index]['price'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
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
