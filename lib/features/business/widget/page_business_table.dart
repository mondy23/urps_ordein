import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/paginator_controller.dart';
import 'package:urps_ordein/features/business/provider/business_provider.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';

class BusinessDataTable extends ConsumerWidget {
  const BusinessDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessesAsync = ref.watch(businessListProvider);
    final totalBusiness = ref.watch(totalBusinessCountProvider);
    final currentPage = ref.watch(pageSelectedProvider);

    final minRowCount = 5;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - kToolbarHeight - 190;
    const rowHeight = 56.0;
    final rowCount = (availableHeight / rowHeight).floor().clamp(
      minRowCount,
      999,
    );

    // ✅ Post-frame callback to update row count and validate current page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rowCountProvider.notifier).state = rowCount;

      final totalPages = (totalBusiness / rowCount).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        ref.read(pageSelectedProvider.notifier).state = totalPages;
      }
    });

    return businessesAsync.when(
      data: (businesses) {
        // ✅ In case backend returns empty due to overflowed page
        if (businesses.isEmpty && currentPage > 1) {
          Future.microtask(() {
            ref.read(pageSelectedProvider.notifier).state = currentPage - 1;
          });
          return const Center(child: CircularProgressIndicator());
        }

        final usersToShow = businesses.take(rowCount).toList();

        return Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columns: _buildDataColumns(),
                  rows: usersToShow.map((b) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Icon(Icons.circle, color: textColor, size: 36),
                              const SizedBox(width: 8),
                              Text(b.businessName ?? ''),
                            ],
                          ),
                        ),
                        DataCell(Text(b.industry ?? '')),
                        DataCell(
                          Text(
                            DateFormat(
                              'MMM d, yyyy',
                            ).format(b.createdAt ?? DateTime.now()),
                          ),
                        ),
                        DataCell(Text('${b.totalUsers}')),
                        DataCell(Text('${b.pointsReleased}')),
                        DataCell(Text('${b.pointsRedeemed}')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                tooltip: "User's",
                                icon: Icon(
                                  Icons.person_outline,
                                  color: secondaryColor,
                                ),
                                onPressed: () {
                                  ref.read(businessIDProvider.notifier).state = b.businessID!;
                                  context.go(
                                    '/businesses/${b.businessID}/users',
                                  );
                                },
                              ),
                              IconButton(
                                tooltip: 'Edit',
                                icon: Icon(Icons.edit, color: primaryColor),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 16),
              child: Row(
                children: [
                  const Spacer(),
                  TablePaginator(
                    totalRows: totalBusiness,
                    rowsPerPage: rowCount,
                    currentPage: currentPage,
                  ),
                ],
              ),
            ),
          ],
        );
      },
      error: (error, stack) => Center(child: Text('No data found')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  List<DataColumn> _buildDataColumns() {
    const columns = [
      'Business Name',
      'Industry',
      'Created At',
      'Total Users',
      'Points Released',
      'Points Redeemed',
      'Actions',
    ];

    return columns.map((label) {
      return DataColumn(
        label: Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(255, 147, 151, 161),
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }).toList();
  }
}
