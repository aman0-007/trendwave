import 'package:flutter/material.dart';

class OffCategoriesPage extends StatefulWidget {
  const OffCategoriesPage({super.key});

  @override
  _OffCategoriesPageState createState() => _OffCategoriesPageState();
}

class _OffCategoriesPageState extends State<OffCategoriesPage> {

  @override
  Widget build(BuildContext context) {
    // Static content inside the widget
    final String title = 'Up to 70% off | Kitchen tools, water bottles & more from emerging brands';
    final List<String> images = [
      'https://preview.redd.it/l3mfsfqmobzd1.jpeg?width=1080&crop=smart&auto=webp&s=149febe78ed7edb106c667a7922938ac098a9d26',
      'https://preview.redd.it/first-try-at-product-photos-v0-prkx1637ayyd1.jpg?width=1080&crop=smart&auto=webp&s=018f96823b051bfdbbcf0d5e36ad6e9d4a2bcfd2',
      'https://preview.redd.it/first-try-at-product-photos-v0-wpbcy437ayyd1.jpg?width=1080&crop=smart&auto=webp&s=a6daa905f5a92130ca0191e61a9da55661fc79b7',
      'https://preview.redd.it/looking-for-options-v0-hmusks2m2rxd1.jpg?width=1080&crop=smart&auto=webp&s=1263ac3064dcb6a327deeb9742bbb8bd3c135dc1',
      'https://i.redd.it/z9eahcncydxd1.jpeg',
      'https://preview.redd.it/looking-for-feedback-on-my-first-product-shoot-v0-vus7phd893xd1.jpg?width=1080&crop=smart&auto=webp&s=d77c1613d6967681c0db2018e529ac2acd4c8bc7',
      'https://preview.redd.it/bgfhcedp3qvd1.jpg?width=1080&crop=smart&auto=webp&s=3aafdb19dc10281073017b8cd8026b85107eb4d4',
      'https://preview.redd.it/sharing-my-recent-product-photos-v0-2zvg7cn4k9vd1.jpg?width=1080&crop=smart&auto=webp&s=2ae4fb6187d339dc31c1b7dee95c570a6fb299e6',
      'https://preview.redd.it/seltzer-photos-i-made-for-my-portfolio-modeled-on-similar-v0-zxoh9lpyhzud1.jpg?width=3000&format=pjpg&auto=webp&s=be9df3c5e716a1970efd88ec25401dd2896d87c7',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 2), // Space before the grid of images

          // Non-scrollable Grid of images with 3 columns
          Container(
            height: MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
            child: GridView.count(
              crossAxisCount: 3, // 3 images per row
              crossAxisSpacing: 8.0, // Space between columns
              mainAxisSpacing: 8.0, // Space between rows
              childAspectRatio: 1.0, // Square images
              physics: NeverScrollableScrollPhysics(), // Disables scrolling
              children: List.generate(images.length, (index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
