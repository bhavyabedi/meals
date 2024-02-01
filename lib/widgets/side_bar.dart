import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    required this.onSelect,
  });

  final void Function(String identifier) onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.food_bank_outlined,
                  size: 48,
                ),
                Text(
                  'Lets\'s Cook!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 35,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelect('Home');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 35,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelect('Filters');
            },
          ),
        ],
      ),
    );
  }
}
