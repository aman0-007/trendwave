import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _priceController = TextEditingController();

  // Available sizes and selected sizes
  final List<String> sizes = ["S", "M", "L", "XL"];
  Set<String> selectedSizes = {};

  // Colors and selected colors
  final List<Color> availableColors = [
    Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.black
  ];
  Set<Color> selectedColors = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Short Description field
              TextField(
                controller: _shortDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Short Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Long Description field
              TextField(
                controller: _longDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Long Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Size selection
              Text('Sizes Available'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: sizes.map((size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: selectedSizes.contains(size),
                    onSelected: (isSelected) {
                      setState(() {
                        isSelected
                            ? selectedSizes.add(size)
                            : selectedSizes.remove(size);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Color selection
              Text('Colors Available'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: availableColors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColors.contains(color)
                            ? selectedColors.remove(color)
                            : selectedColors.add(color);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColors.contains(color)
                              ? Colors.black
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Price field
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle product addition logic here
                    // You can also print the values or pass them to a backend/database
                  },
                  child: const Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}