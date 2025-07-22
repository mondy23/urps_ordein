import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/point_logs_data.dart';
import 'package:urps_ordein/data/transactions_redemptions_data.dart';
import 'package:urps_ordein/data/user_information_data.dart';
import 'package:urps_ordein/widgets/MyTable.dart';

class SpecificUser extends StatelessWidget {
  final int userID;
  const SpecificUser({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = TextStyle(
      color: const Color.fromARGB(255, 147, 151, 161),
      fontSize: 16,
    );
    final pointsDetails = PointLogsData();
    final TransactionDetails = TransactionsData();
    final RedemptionDetails = RedemptionsData();
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            children: [
              userInformation(),
              pointLogs(pointsDetails, headerTextStyle),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              // rewardAccountSummary(),
              transaction(TransactionDetails, headerTextStyle),
              redemption(RedemptionDetails, headerTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

Widget userInformation() {
  final details = UserInformationData();
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          cardHeader('User Information', Icons.person_outline),
          Text(details.data.id.toString()),
          Text(details.data.name),
          Text(details.data.mobileNumber),
           Text(DateFormat().format(details.data.birthdate)),
          Text(details.data.linkedBusiness),
          Text(DateFormat().format(details.data.joined)),
          Text(details.data.points.toString()),
        ],
      ),
    ),
  );
}

Widget rewardAccountSummary() {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [cardHeader('Reward Account Summary', Icons.trending_up)],
      ),
    ),
  );
}

Widget transaction(TransactionsData details, TextStyle headerStyle) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Mytable(
        rows: details.data.map((t) {
          return DataRow(
            cells: [
              DataCell(Text(DateFormat().format(t.dateAndTime))),
              DataCell(Text(t.description)),
              DataCell(
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 216, 249, 217),
                  ),
                  child: Center(
                    child: Text(
                      '+${t.earn.toString()}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        columns: [
          DataColumn(label: Text('Date & Time', style: headerStyle)),
          DataColumn(label: Text('Description', style: headerStyle)),
          DataColumn(label: Text('Earned', style: headerStyle)),
        ],
        tableName: 'Transaction',
        tableIcon: Icons.transfer_within_a_station_outlined,
      ),
    ),
  );
}

Widget redemption(RedemptionsData details, TextStyle headerStyle) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Mytable(
        rows: details.data.map((r) {
          return DataRow(
            cells: [
              DataCell(Text(DateFormat().format(r.dateAndTime))),
              DataCell(Text(r.description)),
              DataCell(
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 249, 216, 216),
                  ),
                  child: Center(
                    child: Text(
                      '-${r.redeemed.toString()}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        columns: [
          DataColumn(label: Text('Date & Time', style: headerStyle)),
          DataColumn(label: Text('Description', style: headerStyle)),
          DataColumn(label: Text('Redeemed', style: headerStyle)),
        ],
        tableName: 'Redemption',
        tableIcon: Icons.redeem_outlined,
      ),
    ),
  );
}

Widget pointLogs(PointLogsData details, TextStyle headerStyle) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            cardHeader('Point Logs(Full History)', Icons.receipt_long_outlined),
            DataTable(
              columns: [
                DataColumn(label: Text('Type', style: headerStyle)),
                DataColumn(label: Text('Points', style: headerStyle)),
                DataColumn(label: Text('Description', style: headerStyle)),
                DataColumn(label: Text('Ref ID', style: headerStyle)),
                DataColumn(label: Text('Time', style: headerStyle)),
              ],
              rows: details.data.map((p) {
                return DataRow(
                  cells: [
                    DataCell(Text(p.type)),
                    DataCell(Text(p.points.toString())),
                    DataCell(Text(p.description)),
                    DataCell(Text(p.refID)),
                    DataCell(Text(DateFormat('MMM d, yyyy').format(p.time))),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
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
