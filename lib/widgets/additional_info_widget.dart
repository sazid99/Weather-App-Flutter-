import 'package:flutter/material.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const AdditionalInfoWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 60,
          color: color,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
