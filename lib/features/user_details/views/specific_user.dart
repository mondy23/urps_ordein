import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';
import 'package:urps_ordein/features/user_details/models/info_model.dart';
import 'package:urps_ordein/features/user_details/models/point_logs_model.dart';
import 'package:urps_ordein/features/user_details/models/redemption_model.dart';
import 'package:urps_ordein/features/user_details/models/transaction_model.dart';
import 'package:urps_ordein/widgets/MyTable.dart';

class SpecificUser extends ConsumerWidget {
  final int userID;
  const SpecificUser({super.key, required this.userID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerTextStyle = TextStyle(
      color: const Color.fromARGB(255, 147, 151, 161),
      fontSize: 16,
    );
    final userDetails = ref.watch(userDetailsProvider);
    return userDetails.when(
      data: (user) {
        return Row(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  userInformation(user!.userInfo),
                  pointLogs(user.pointLogs, headerTextStyle),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  // rewardAccountSummary(),
                  transaction(user.transaction, headerTextStyle),
                  redemption(user.redemption, headerTextStyle),
                ],
              ),
            ),
          ],
        );
      },
      error: (e, _) => Center(
        child: Text(
          'Something went wrong.\n$e',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

Widget userInformation(InfoModel details) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          cardHeader('User Information', Icons.person_outline),
          Text(details.userID),
          Text(details.businessID.toString()),
          Text(DateFormat().format(details.createdAt)),
          Text(details.totalPoints.toString()),
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

Widget transaction(TransactionResponse details, TextStyle headerStyle) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Mytable(
        rows: details.transactions.map((t) {
          return DataRow(
            cells: [
              DataCell(Text(DateFormat().format(t.transactionTime))),
              DataCell(Text('jkhgb')),
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
                      '+${t.pointsEarned.toString()}',
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

Widget redemption(RedemptionResponse details, TextStyle headerStyle) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Mytable(
        rows: details.redemptions.map((r) {
          return DataRow(
            cells: [
              DataCell(Text(DateFormat().format(r.redemptionTime))),
              DataCell(Text('dasdas')),
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
                      '-${r.reward.toString()}',
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

Widget pointLogs(PointLogsResponse details, TextStyle headerStyle) {
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
              rows: details.pointLogs.map((p) {
                return DataRow(
                  cells: [
                    DataCell(Text(p.type)),
                    DataCell(Text(p.points.toString())),
                    DataCell(Text('aasda')),
                    DataCell(Text(p.pointLogID.toString())),
                    DataCell(Text(DateFormat('MMM d, yyyy').format(p.timestamp))),
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
