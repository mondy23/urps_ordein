import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/paginator_controller.dart';
import 'package:urps_ordein/features/business/controllers/users_provider.dart';
import 'package:urps_ordein/features/business/model/user_model.dart';
import 'package:urps_ordein/features/business/views/widgets/business_line_chart.dart';
import 'package:urps_ordein/features/user_details/views/widgets/circle_percent.dart';
import 'package:urps_ordein/widgets/error_no_data.dart';

class UsersTable extends ConsumerWidget {
  final int businessID;
  const UsersTable({super.key, required this.businessID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usertable = ref.watch(usersProvider(1));
    return usertable.when(
      data: (data) {
        if (data == null) {
          return ErrorNoData();
        }
        return Container(
          height: 475,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Users',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: DataTable(
                          showCheckboxColumn: false,
                          columnSpacing: 32,
                          headingRowHeight: 48,
                          dataRowHeight: 56,
                          columns: _buildColumns(),
                          rows: _buildRows(context ,data),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TablePaginator(totalRows: 5, rowsPerPage: 5, currentPage: 1),
                ],
              ),
            ],
          ),
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

  List<DataColumn> _buildColumns() {
    const headers = ['ID', 'Points', 'Rank', 'Progress', 'Joined'];
    return headers
        .map(
          (title) => DataColumn(
            label: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
        .toList();
  }

List<DataRow> _buildRows(BuildContext context, List<UserModel> data) {
  return data.map((row) {
    return DataRow(
      onSelectChanged: (selected) {
        if (selected == true) {
          context.go('/businesses/$businessID/users/${row.accountIdentifier}/details');

        }
      },
      cells: [
        _dataCell(row.accountIdentifier),
        _dataCell(
          formatPoints(row.totalPoints),
          bold: true,
          color: primaryColor,
        ),
        _dataCell(
          getRank(row.totalPoints),
          bold: true,
          color: getRankColor(row.totalPoints),
        ),
        DataCell(
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: getProgressValue(row.totalPoints),
              minHeight: 8,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ),
        _dataCell(
          row.createdAt != null
              ? DateFormat('MMM d, y').format(row.createdAt!)
              : 'N/A',
        ),
      ],
    );
  }).toList();
}



  DataCell _dataCell(String text, {bool bold = false, Color? color}) {
    return DataCell(
      Text(
        text,
        style: TextStyle(
          color: color ?? textColor,
          fontSize: 18,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Color getRankColor(int points) {
    String rank = getRank(points);
    if (rank == 'Bronse') return Colors.brown;
    if (rank == 'Silver') return Colors.grey;
    if (rank == 'Gold') return Colors.orangeAccent;
    return Colors.brown;
  }

double getProgressValue(int points) {
  final rankThresholds = {
    'Bronze': 0,
    'Silver': 100,
    'Gold': 1000,
    'Platinum': 3000,
    'Diamond': 5000,
    'Master': 10000, // max cap
  };

  final entries = rankThresholds.entries.toList();

  for (int i = 0; i < entries.length - 1; i++) {
    final current = entries[i];
    final next = entries[i + 1];

    if (points >= current.value && points < next.value) {
      final range = next.value - current.value;
      final progress = (points - current.value) / range;
      return progress.clamp(0.0, 1.0);
    }
  }

  return 1.0;
}
}
