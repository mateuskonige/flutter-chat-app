import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeSwitcher extends StatelessWidget {
  const DarkModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ThemeProvider>(context).isDarkMode,
      onChanged: (value) =>
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.dark_mode);
        }
        return const Icon(Icons.light_mode);
      }),
    );
  }
}
