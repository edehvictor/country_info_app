import 'package:flutter/material.dart';

class SeachBar extends StatelessWidget {
  SeachBar({super.key, required this.searchValue, required this.themeMode});
  final void Function(String text) searchValue;
  final TextEditingController searchController = TextEditingController();
  final bool themeMode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        onChanged: searchValue,
        decoration: InputDecoration(
          labelText: 'Search by country name...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          fillColor: themeMode ? Color(0xFF2C2C2C) : Color(0xFFF2F4F7),
          filled: true,
        ),
      ),
    );
  }
}
