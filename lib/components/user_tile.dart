import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const UserTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: ListTile(title: Text(title)),
      ),
    );
  }
}
