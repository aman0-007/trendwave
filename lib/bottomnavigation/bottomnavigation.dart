import 'package:flutter/material.dart';
import 'package:trendwave/pages/homepage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const HomePage(),
    const CartScreen(),
    const LikeScreen(),
    const ProfileScreen(),
  ];

  // Update the selected tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    const backgroundColor = Color(0xFF212121); // Dark background for the navigation bar
    const selectedColor = Colors.white; // Color for selected tab (white)
    final textColor = theme.brightness == Brightness.light
        ? const Color(0xFF333333)
        : const Color(0xFFCCCCCC); // Header text color based on theme

    return Scaffold(
      body: _pages[_selectedIndex], // Show the selected page
      backgroundColor: theme.scaffoldBackgroundColor, // Set background according to theme
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: backgroundColor, // Set to dark background
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              _onItemTapped(index);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _selectedIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == _selectedIndex ? displayWidth * .12 : 0,
                    width: index == _selectedIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == _selectedIndex
                          ? const Color(0xFF333333) // Darker shade for selected tab background
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _selectedIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _selectedIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == _selectedIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == _selectedIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: const TextStyle(
                                color: selectedColor, // White for selected text
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _selectedIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == _selectedIndex
                                ? selectedColor // White for selected icon
                                : secondaryColor, // Unselected icon color
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.shopping_cart_rounded,
    Icons.favorite_rounded,
    Icons.account_circle_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Cart',
    'Likes',
    'Profile',
  ];
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Cart Screen', style: Theme.of(context).textTheme.bodyMedium));
  }
}

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Likes Screen', style: Theme.of(context).textTheme.bodyMedium));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Screen', style: Theme.of(context).textTheme.bodyMedium));
  }
}
