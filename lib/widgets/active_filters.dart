import 'package:flutter/material.dart';

class ActiveFilters extends StatelessWidget {
  final String selectedContinent;
  final String selectedTimezone;
  final Function() clearContinent;
  final Function() clearTimezone;

  const ActiveFilters({
    super.key,
    required this.selectedContinent,
    required this.selectedTimezone,
    required this.clearContinent,
    required this.clearTimezone,
  });
  @override
  Widget build(BuildContext context) {
    if (selectedContinent != 'All' || selectedTimezone != 'All') ;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text('Active filters: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          if (selectedContinent != 'All')
            Chip(
              label: Text(selectedContinent),
              onDeleted: clearContinent,
            ),
          SizedBox(width: 8),
          if (selectedTimezone != 'All')
            Chip(
              label: Text(selectedTimezone),
              onDeleted: clearTimezone,
            ),
        ],
      ),
    );
  }
}
