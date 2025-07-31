import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class Mytable extends StatelessWidget {
  final List <DataRow>rows;
  final List <DataColumn>columns;
  final String tableName;
  final IconData tableIcon;
  const Mytable({super.key, required this.rows, required this.columns, required this.tableName, required this.tableIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          cardHeader(tableName, tableIcon),
          Expanded(
            child: ListView(
              children: [
                DataTable(
                  columns: columns,
                  rows: rows,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget cardHeader(String name, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, left: 16),
        child: Icon(icon, size: 32, color: textColor),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 24),
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}