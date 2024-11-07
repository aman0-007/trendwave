import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  final List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL", "3XL"];
  Set<String> selectedSizes = {};

  final List<Color> availableColors = [
    Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.black,
    Colors.purple, Colors.orange, Colors.teal, Colors.pink, Colors.brown
  ];
  Set<Color> selectedColors = {};
  Map<Color, List<File>> colorImages = {}; // Multiple images per color

  bool _isButtonPressed = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'Product Name',
                controller: _nameController,
                theme: theme,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Short Description',
                controller: _shortDescriptionController,
                theme: theme,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Long Description',
                controller: _longDescriptionController,
                theme: theme,
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              Text('Sizes Available', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: sizes.map((size) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(size),
                        selected: selectedSizes.contains(size),
                        onSelected: (isSelected) {
                          setState(() {
                            isSelected ? selectedSizes.add(size) : selectedSizes.remove(size);
                          });
                        },
                        selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: selectedSizes.contains(size)
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              Text('Colors Available', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...availableColors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedColors.contains(color)) {
                              selectedColors.remove(color);
                              colorImages.remove(color);
                            } else {
                              selectedColors.add(color);
                              colorImages[color] = [];
                            }
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColors.contains(color)
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    GestureDetector(
                      onTap: () => _pickColor(),
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Text('Upload Images for Selected Colors', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              Column(
                children: selectedColors.map((color) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _pickImageForColor(color),
                            child: Text(
                              'Upload Image',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: colorImages[color]?.map((imageFile) {
                          return Image.file(
                            imageFile,
                            width: 50,
                            height: 50,
                          );
                        }).toList() ?? [],
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Price',
                controller: _priceController,
                theme: theme,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.04,),

              Center(
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: () {
                    // Handle product addition logic here
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: screenWidth * 0.35,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: _isButtonPressed
                          ? []
                          : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      "Add Product",
                      style: theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickColor() async {
    Color selectedColor = Colors.blue;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) => selectedColor = color,
              enableAlpha: false,
              showLabel: false,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                setState(() {
                  availableColors.add(selectedColor);
                  selectedColors.add(selectedColor);
                  colorImages[selectedColor] = [];
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageForColor(Color color) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        colorImages[color] = (colorImages[color] ?? [])..add(File(pickedFile.path));
      });
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: theme.colorScheme.primaryContainer.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
