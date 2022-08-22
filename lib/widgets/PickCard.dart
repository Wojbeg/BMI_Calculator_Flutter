import 'package:flutter/material.dart';


class PickCard extends StatelessWidget {

  const PickCard({required this.color, required this.child, required this.onTap, Key? key}) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: child,
      ),
    );
  }
}
