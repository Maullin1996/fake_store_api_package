import 'package:example/config/design/tokens.dart';
import 'package:example/config/mock/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Methods',
          style: textTheme.displayLarge?.copyWith(color: AppColors.background),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryVariant,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.medium,
          horizontal: AppSpacing.small,
        ),
        itemCount: menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          final menuItem = menuItems[index];
          return ListTile(
            title: Text(
              menuItem.title,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryVariant,
              ),
            ),
            subtitle: Text(menuItem.subTitle, style: textTheme.labelSmall),
            leading: Icon(menuItem.icon, color: AppColors.primary, size: 35),
            onTap: () {
              context.push(menuItem.route);
            },
          );
        },
      ),
    );
  }
}
