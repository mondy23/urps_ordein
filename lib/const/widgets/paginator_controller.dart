import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/features/business/controllers/business_provider.dart';

class TablePaginator extends ConsumerWidget {
  final int totalRows;
  final int rowsPerPage;
  final int currentPage;

  const TablePaginator({
    super.key,
    required this.totalRows,
    required this.rowsPerPage,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPages = (totalRows / rowsPerPage).ceil();

    void goToPage(int page) {
      if (page >= 1 && page <= totalPages) {
        ref.read(pageSelectedProvider.notifier).state = page;
      }
    }

    // Automatically fix overflow page
    if (currentPage > totalPages && totalPages > 0) {
      Future.microtask(() => goToPage(totalPages));
    }

    List<Widget> pageButtons = [];

    // Always show first page
    pageButtons.add(_paginationPage(
      label: '1',
      isActive: currentPage == 1,
      onTap: () => goToPage(1),
    ));

    // Middle page numbers
    for (int i = currentPage - 2; i <= currentPage + 2; i++) {
      if (i > 1 && i < totalPages) {
        pageButtons.add(_paginationPage(
          label: '$i',
          isActive: currentPage == i,
          onTap: () => goToPage(i),
        ));
      }
    }

    // Ellipsis
    if (currentPage < totalPages - 3) {
      pageButtons.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('...'),
      ));
    }

    // Always show last page
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
}

// === Helper Widgets ===

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
    ),
    color: isActive ? primaryColor : backgroundColor,
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
