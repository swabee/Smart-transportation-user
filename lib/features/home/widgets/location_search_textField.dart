// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:user_app/constant/app_constant.dart';

class LocationSearchCustomTextField extends StatefulWidget {
  final List<Map<String, dynamic>> depots;
  final Function(String) onSelected;
  final String fieldName;

  const LocationSearchCustomTextField({
    required this.depots,
    required this.onSelected,
    required this.fieldName,
    super.key,
  });

  @override
  State<LocationSearchCustomTextField> createState() =>
      _LocationSearchCustomTextFieldState();
}

class _LocationSearchCustomTextFieldState
    extends State<LocationSearchCustomTextField> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _filteredDepots = [];
  bool _showSuggestions = false;

  void _filterDepots(String query) {
    setState(() {
      if (query.isEmpty) {
        _showSuggestions = false;
        _filteredDepots = [];
      } else {
        _filteredDepots = widget.depots
            .where((depot) =>
                depot['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
        _showSuggestions = _filteredDepots.isNotEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search TextField
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.fieldName,
            fillColor: primaryColor.withOpacity(.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: primaryColor),
            ),
            prefixIcon: const Icon(Icons.location_on, color: Colors.green),
          ),
          onChanged: _filterDepots,
        ),
        const SizedBox(height: 10),
        // Suggestions List
        if (_showSuggestions)
          Container(
            height: 200, // Adjust height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: primaryColor.withOpacity(.1),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: ListView.builder(
              itemCount: _filteredDepots.length,
              itemBuilder: (context, index) {
                final depot = _filteredDepots[index];
                return ListTile(
                  title: Text(depot['name']),
                  onTap: () {
                    _controller.text = depot['name'];
                    widget.onSelected(depot['name']);
                    setState(() {
                      _showSuggestions =
                          false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
