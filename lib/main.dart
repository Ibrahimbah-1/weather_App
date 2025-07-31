import 'package:flutter/material.dart';
import 'screens/current_weather.dart';
import 'screens/forecast.dart';
import 'screens/location.dart';
import 'screens/settings.dart';
import 'widgets/bottom_nav.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> _screens = [
    CurrentWeatherScreen(key: const PageStorageKey('weather')),
    ForecastScreen(key: const PageStorageKey('forecast')),
    LocationScreen(key: const PageStorageKey('location')),
    SettingsScreen(key: const PageStorageKey('settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}