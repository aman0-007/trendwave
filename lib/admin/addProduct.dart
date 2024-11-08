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
  final ImagePicker _picker = ImagePicker();

  final List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL", "3XL"];
  Map<String, int> sizeQuantities = {};

  final List<Color> availableColors = [
    Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.black,
  ];
  Color? selectedColor;
  List<File> colorImages = [];

  final List<Map<String, dynamic>> products = [];
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              _buildSizeSelection(theme),
              const SizedBox(height: 16),

              Text('Select Color', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              _buildColorPicker(theme),
              const SizedBox(height: 16),

              if (selectedColor != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload Images for Selected Color', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _pickImages,
                      child: const Text('Upload Images'),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: colorImages
                          .map((imageFile) => Stack(
                        children: [
                          Image.file(
                            imageFile,
                            width: 50,
                            height: 50,
                          ),
                          Positioned(
                            right: -10,
                            top: -10,
                            child: IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () => _removeImage(imageFile),
                            ),
                          ),
                        ],
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              _buildTextField(
                label: 'Price',
                controller: _priceController,
                theme: theme,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: _addMore,
                child: const Text('+ Add More'),
              ),
              const SizedBox(height: 16),

              Center(
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: _addProduct,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 64),
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

  Widget _buildSizeSelection(ThemeData theme) {
    return Wrap(
      spacing: 8,
      children: sizes.map((size) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(size),
              if (sizeQuantities.containsKey(size))
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      onPressed: () {
                        setState(() {
                          if (sizeQuantities[size]! > 1) {
                            sizeQuantities[size] = sizeQuantities[size]! - 1;
                          }
                        });
                      },
                    ),
                    Text(sizeQuantities[size].toString(), style: theme.textTheme.bodySmall),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      onPressed: () {
                        setState(() {
                          sizeQuantities[size] = sizeQuantities[size]! + 1;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
          selected: sizeQuantities.containsKey(size),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                sizeQuantities[size] = 1;
              } else {
                sizeQuantities.remove(size);
              }
            });
          },
          selectedColor: theme.colorScheme.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: sizeQuantities.containsKey(size)
                ? theme.colorScheme.primary
                : theme.textTheme.bodySmall?.color,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorPicker(ThemeData theme) {
    return Row(
      children: [
        ...availableColors.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
                colorImages.clear(); // Clear images when a new color is selected
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
                  color: selectedColor == color
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).take(5), // Display only 5 colors
        GestureDetector(
          onTap: _openColorPickerDialog,
          child: Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  void _openColorPickerDialog() async {
    Color selected = Colors.blue;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selected,
              onColorChanged: (color) => selected = color,
              enableAlpha: false,
              showLabel: false,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                setState(() {
                  availableColors.add(selected);
                  selectedColor = selected;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImages() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        colorImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(File imageFile) {
    setState(() {
      colorImages.remove(imageFile);
    });
  }

  void _addMore() {
    final newProduct = {
      'name': _nameController.text,
      'shortDesc': _shortDescriptionController.text,
      'longDesc': _longDescriptionController.text,
      'sizes': Map<String, int>.from(sizeQuantities),
      'color': selectedColor,
      'images': List<File>.from(colorImages),
      'price': double.tryParse(_priceController.text)?.toStringAsFixed(2),
    };
    products.add(newProduct);
    setState(() {});
  }

  void _addProduct() {
    _addMore();
    // Handle final submission of all products here
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? prefixIcon,
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
        prefixIcon: prefixIcon,
      ),
    );
  }
}
