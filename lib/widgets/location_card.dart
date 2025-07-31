import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String city;
  final String country;
  final bool current;

  const LocationCard({
    super.key,
    required this.city,
    required this.country,
    this.current = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.blue),
        title: Text(
          city,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(country),
        trailing: current
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Current',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            : const Icon(Icons.chevron_right),
      ),
    );
  }
}