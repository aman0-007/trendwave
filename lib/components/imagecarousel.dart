import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> images = [
    'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?q=80&w=1778&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://media.istockphoto.com/id/675623820/photo/black-leather-crossbody-bag-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=3Ir3h3dkTtbMZ2H7k_z2OxsPRMrt6SI85SpaHYXW82I=',
    'https://images.unsplash.com/photo-1511765224389-37f0e77cf0eb?fit=crop&w=1778&q=80',
    'https://plus.unsplash.com/premium_photo-1664391658474-c5509d4fc003?q=80&w=1960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?q=80&w=1778&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  late final PageController _pageController;
  late final Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Auto-scroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first image
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading for the Carousel
          Text(
            'Trending Products',
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),

          // Carousel using PageView
          SizedBox(
            height: 200, // Height of the carousel
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              physics: const ClampingScrollPhysics(), // Disables looping
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
