import 'package:flutter/material.dart';

class ErrorNoData extends StatelessWidget {
  const ErrorNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.info_outline, size: 48, color: Colors.grey),
      SizedBox(height: 8),
      Text('No data available.', style: TextStyle(fontSize: 16)),
    ],
  ),
);
  }
}