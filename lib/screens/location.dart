import 'package:flutter/material.dart';
import '../widgets/location_card.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final List<Map<String, String>> _locations = [
    {'city': 'New York', 'country': 'USA'},
    {'city': 'London', 'country': 'UK'},
    {'city': 'Tokyo', 'country': 'Japan'},
  ];
  List<Map<String, String>> _filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredLocations = _locations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search city...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _filteredLocations = _locations
                  .where((loc) => loc['city']!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredLocations.length,
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          return GestureDetector(
            onTap: () {
              // Navigate to weather for this location
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Loading ${location['city']} weather')),
              );
            },
            child: LocationCard(
              city: location['city']!,
              country: location['country']!,
              current: index == 0,
            ),
          );
        },
      ),
    );
  }
}