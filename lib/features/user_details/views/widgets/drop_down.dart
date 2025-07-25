import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String? selectedWeek;

  final List<String> weeks = ['Day', 'Week', 'Year'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(16),
          hint: const Text("Select a day"),
          value: selectedWeek,
          items: weeks.map((String week) {
            return DropdownMenuItem<String>(
              value: week,
              child: Text(week),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedWeek = newValue;
            });
          },
        ),
      ),
    );
  }
}
