// import 'package:flutter/material.dart';

// class Newcountry extends StatefulWidget {
//   const Newcountry(
//       {super.key, required this.filterFcn, required this.selectedContinent});

//   final Function filterFcn;
//   final String selectedContinent;
//   @override
//   State<StatefulWidget> createState() => _NewCountryState();
// }

// class _NewCountryState extends State<Newcountry> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Continent',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           DropdownButton<String>(
//             isExpanded: true,
//             value: selectedContinent,
//             onChanged: (String? newValue) {
//               setModalState(() {
//                 selectedContinent = newValue!;
//               });
//             },
//             items: <String>[
//               'All',
//               'Africa',
//               'Asia',
//               'Europe',
//               'Oceania',
//               'Americas'
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Timezone',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           DropdownButton<String>(
//             isExpanded: true,
//             value: selectedTimezone,
//             onChanged: (String? newValue) {
//               setModalState(() {
//                 selectedTimezone = newValue!;
//               });
//             },
//             items: <String>[
//               'All',
//               'UTC+02:00',
//               'UTC+01:00',
//               'UTC+03:00',
//               'UTC-04:00',
//               'UTC+07:00'
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setModalState(() {
//                     selectedContinent = 'All';
//                     selectedTimezone = 'All';
//                   });
//                 },
//                 child: Text('Reset'),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFFF6C00),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   setState(() {
//                     filterFcn;
//                   });
//                 },
//                 child: Text('Show result'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
