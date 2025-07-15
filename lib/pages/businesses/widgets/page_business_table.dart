import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/api/business_api_provider.dart';
import 'package:urps_ordein/const/constant.dart';

class BusinessDataTable extends ConsumerWidget {
  const BusinessDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minRowCount = 5;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - kToolbarHeight - 190;
    const rowHeight = 56.0;
    var rowCount = (availableHeight / rowHeight).floor().clamp(
      minRowCount,
      999,
    );
    final currentPage = ref.watch(pageSelected);
    // Update the provider
    Future.microtask(() {
      ref.read(rowCountProvider.notifier).state = rowCount;
      ref.read(pageSelected.notifier).state = currentPage;
    });
    final businessesAsync = ref.watch(businessesProvider);

    return businessesAsync.when(
      data: (businesses) {
        final usersToShow = businesses.businesses.take(rowCount).toList();
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
                              Text(b.businessName),
                            ],
                          ),
                        ),
                        DataCell(Text(b.industry)),
                        DataCell(Text(DateFormat('MMM d, yyyy').format(b.createdAt))),
                        DataCell(Text('${b.totalUsers}')),
                        DataCell(Text('${b.pointsReleased}')),
                        DataCell(Text('${b.pointsRedeemed}')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                tooltip: "User's",
                                icon: Icon(Icons.person_outline, color: secondaryColor),
                                onPressed: () => context.go('/businesses/users'),
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
                        children: [const Spacer(), _tableControllers(ref, businesses.count, rowCount, currentPage)],
                      ),
                    ),
          ],
        );
      },
      error: (error, stack) => Center(child: Text('❌ Error: $error')),
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
    return columns
        .map(
          (label) => DataColumn(
            label: Text(
              label,
              style: TextStyle(
                color: Color.fromARGB(255, 147, 151, 161),
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
        .toList();
  }
}

Widget _tableControllers(
  WidgetRef ref,
  int totalRow,
  int rowCountPerScreen,
  int currentPage,
) {
  final totalPages = (totalRow / rowCountPerScreen).ceil();
  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      ref.read(pageSelected.notifier).state = page;
    }
  }

  List<Widget> pageButtons = [];

  // Always show first page
  pageButtons.add(_paginationPage(
    label: '1',
    isActive: currentPage == 1,
    onTap: () => goToPage(1),
  ));

  // Ellipsis before middle pages
  // if (currentPage > 4) {
  //   pageButtons.add(const Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 8),
  //     child: Text('...'),
  //   ));
  // }

  // Middle pages (±2 around current)
  for (int i = currentPage - 2; i <= currentPage + 2; i++) {
    if (i > 1 && i < totalPages) {
      pageButtons.add(_paginationPage(
        label: '$i',
        isActive: currentPage == i,
        onTap: () => goToPage(i),
      ));
    }
  }

  // Ellipsis after middle pages
  if (currentPage < totalPages - 3) {
    pageButtons.add(const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text('...'),
    ));
  }

  // Always show last page (if more than 1)
  if (totalPages > 1) {
    pageButtons.add(_paginationPage(
      label: '$totalPages',
      isActive: currentPage == totalPages,
      onTap: () => goToPage(totalPages),
    ));
  }

  return Padding(
    padding: const EdgeInsets.only(right: 28),
    child: Row(
      children: [
        _paginationButton(
          icon: Icons.chevron_left,
          onTap: () => goToPage(currentPage - 1),
        ),
        ...pageButtons,
        _paginationButton(
          icon: Icons.chevron_right,
          onTap: () => goToPage(currentPage + 1),
        ),
      ],
    ),
  );
}



Widget _paginationPage({
  required String label,
  required VoidCallback onTap,
  bool isActive = false,
}) {
  return _paginationContainer(
    onTap: onTap,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: isActive ? Colors.white : Colors.black,
      ),
    ), color: isActive ? primaryColor : backgroundColor,
  );
}

Widget _paginationButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return _paginationContainer(
    color: backgroundColor,
    onTap: onTap,
    child: Icon(icon, size: 20),
  );
}

Widget _paginationContainer({
  required Color color,
  required Widget child,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ),
    ),
  );
}

