import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.filterFcn});
  final void Function() filterFcn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.public, size: 24),
              SizedBox(width: 8),
              Text(
                'EN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: filterFcn,
            icon: Icon(Icons.filter_list, size: 24),
            tooltip: 'Filter countries',
          ),
        ],
      ),
    );
  }
}
