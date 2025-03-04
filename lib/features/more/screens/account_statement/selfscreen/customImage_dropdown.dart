import 'package:flutter/material.dart';

class CustomImageDropdown extends StatefulWidget {
  final Function(String?)? onItemSelected;

  const CustomImageDropdown({super.key, this.onItemSelected});

  @override
  _CustomImageDropdownState createState() => _CustomImageDropdownState();
}

class _CustomImageDropdownState extends State<CustomImageDropdown> {
  String? _selectedItem;

  // Simple list of items with values
  final List<Map<String, String>> _items = [
    {'value': 'Savings'},
    {'value': 'Current'},
    {'value': 'Option 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedItem,
      hint: const Text('Select an option'),
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
        });
        if (widget.onItemSelected != null) {
          widget.onItemSelected!(_selectedItem);
        }
      },
      items: _items.map<DropdownMenuItem<String>>((Map<String, String> item) {
        return DropdownMenuItem<String>(
          value: item['value'],
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(item['value']!),
            ],
          ),
        );
      }).toList(),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      underline: Container(),
      dropdownColor: Colors.white,
    );
  }
}
