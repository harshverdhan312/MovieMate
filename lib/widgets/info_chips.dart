import 'package:flutter/material.dart';

class InfoChips extends StatelessWidget {
  final String information;
  const InfoChips({
    super.key,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          information,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
