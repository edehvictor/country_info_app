import 'package:country_info/data/fetch_countries.dart';
import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/active_filters.dart';
import 'package:country_info/widgets/countries_list.dart';
import 'package:country_info/widgets/filter_button.dart';
import 'package:country_info/widgets/seach_bar.dart';
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
    filteredCountries.sort((a, b) => a.commonName.compareTo(b.commonName));
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
                  isExpanded: false,
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
                  isExpanded: false,
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
        allCountries.sort((a, b) => a.commonName.compareTo(b.commonName));
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
          SeachBar(searchValue: handleSearch, themeMode: isDarkMode),
          FilterButton(filterFcn: _openFilterModal),
          ActiveFilters(
              selectedContinent: selectedContinent,
              selectedTimezone: selectedTimezone,
              clearContinent: () => setState(() => selectedContinent = 'All'),
              clearTimezone: () => setState(() => selectedTimezone = 'All')),
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
