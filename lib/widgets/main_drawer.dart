import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile(String title, IconData icon, VoidCallback topHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: const Color(0xFF2F4F4F),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F4F4F)),
      ),
      onTap: topHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            color: const Color(0xFF56C49A),
            child: Row(
              children: [
                Icon(
                  Icons.dining,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 56,
                ),
                const Text(
                  'Cooking Up!',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Color(0xFF2F4F4F)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          })
        ],
      ),
    );
  }
}
