import 'package:country_info/data/fetch_countries.dart';
import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/countries_list.dart';
import 'package:flutter/material.dart';

class Countries extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const Countries({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<Countries> createState() {
    return _CountriesState();
  }
}

class _CountriesState extends State<Countries> {
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  List<CountriesModel> allCountries = [];
  List<CountriesModel> filteredCountries = [];

  String selectedContinent = 'All';
  String selectedTimezone = 'All';

  void handleSearch(String query) {
    setState(() {
      searchQuery = query;
      _filterCountries();
    });
  }

  void _filterCountries() {
    filteredCountries = allCountries.where((country) {
      bool matchesSearch =
          country.commonName.toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesContinent = selectedContinent == 'All' ||
          country.continents.contains(selectedContinent);

      bool matchesTimezone = selectedTimezone == 'All' ||
          country.timezones.contains(selectedTimezone);

      return matchesSearch && matchesContinent && matchesTimezone;
    }).toList();
  }

  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continent',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedContinent,
                  onChanged: (String? newValue) {
                    setModalState(() {
                      selectedContinent = newValue!;
                    });
                  },
                  items: <String>[
                    'All',
                    'Africa',
                    'Asia',
                    'Europe',
                    'Oceania',
                    'Americas'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Timezone',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedTimezone,
                  onChanged: (String? newValue) {
                    setModalState(() {
                      selectedTimezone = newValue!;
                    });
                  },
                  items: <String>[
                    'All',
                    'UTC+02:00',
                    'UTC+01:00',
                    'UTC+03:00',
                    'UTC-04:00',
                    'UTC+07:00'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setModalState(() {
                          selectedContinent = 'All';
                          selectedTimezone = 'All';
                        });
                      },
                      child: Text('Reset'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6C00),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _filterCountries();
                        });
                      },
                      child: Text('Show result'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final countries = await fetchCountries();
      setState(() {
        allCountries = countries;
        filteredCountries = countries;
      });
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: !isDarkMode
            ? Image(
                image: AssetImage(
                  'assets/images/ex_logo.png',
                ),
                fit: BoxFit.cover,
                width: 120,
              )
            : Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                fit: BoxFit.cover,
                width: 120,
              ),
        actions: [
          IconButton(
            onPressed: () => widget.toggleTheme(),
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 25,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: handleSearch,
              decoration: InputDecoration(
                labelText: 'Search by country name...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                fillColor: isDarkMode ? Color(0xFF2C2C2C) : Color(0xFFF2F4F7),
                filled: true,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  onPressed: _openFilterModal,
                  icon: Icon(Icons.filter_list, size: 24),
                  tooltip: 'Filter countries',
                ),
              ],
            ),
          ),
          if (selectedContinent != 'All' || selectedTimezone != 'All')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text('Active filters: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  if (selectedContinent != 'All')
                    Chip(
                      label: Text(selectedContinent),
                      onDeleted: () {
                        setState(() {
                          selectedContinent = 'All';
                          _filterCountries();
                        });
                      },
                    ),
                  SizedBox(width: 8),
                  if (selectedTimezone != 'All')
                    Chip(
                      label: Text(selectedTimezone),
                      onDeleted: () {
                        setState(() {
                          selectedTimezone = 'All';
                          _filterCountries();
                        });
                      },
                    ),
                ],
              ),
            ),
          Expanded(
            child: allCountries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : filteredCountries.isEmpty
                    ? Center(child: Text('No country match your filters'))
                    : CountriesList(countries: filteredCountries),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
