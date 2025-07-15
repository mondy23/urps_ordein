import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/pages/specific_user.dart';

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