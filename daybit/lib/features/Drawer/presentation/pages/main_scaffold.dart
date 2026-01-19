import 'package:daybit/features/Home/presentation/home_page.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List of pages - currently only Home, ready for expansion
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      // Placeholder for future pages
      const Center(
        child: Text(
          'Add Page - Coming Soon',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    // Close drawer after selection
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF272727),
      drawer: _buildSideDrawer(),
      body: _pages[_currentPageIndex],
    );
  }

  Widget _buildSideDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF272727),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DAYBIT',
                    style: TextStyle(
                      color: Color(0xFF6FAE6C),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track Your Habits',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24),

            // Navigation Items
            _buildDrawerItem(
              icon: Icons.home_rounded,
              label: 'Home',
              index: 0,
              isActive: _currentPageIndex == 0,
            ),
            _buildDrawerItem(
              icon: Icons.add_circle_outline,
              label: 'Add Habit',
              index: 1,
              isActive: _currentPageIndex == 1,
            ),

            const Spacer(),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFF6FAE6C) : Colors.white70,
        size: 28,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFF6FAE6C) : Colors.white70,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isActive,
      selectedTileColor: const Color.fromRGBO(111, 174, 108, 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      onTap: () => _onNavigationTap(index),
    );
  }
}
