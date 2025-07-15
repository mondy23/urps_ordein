import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/user_cards_data.dart';
import 'package:urps_ordein/data/users_data.dart';
import 'package:urps_ordein/widgets/search_with_botton.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  static const _headerTextStyle = TextStyle(
    color: Color.fromARGB(255, 147, 151, 161),
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    final cardsData = UserCardsData();
    final tableData = UsersData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          SizedBox(height: 160, child: _buildUserCards(cardsData)),
          Expanded(child: _buildUserTable(context, tableData)),
        ],
      ),
    );
  }

  Widget _buildUserCards(UserCardsData details) {
    return GridView.builder(
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        mainAxisExtent: 160,
      ),
      itemBuilder: (context, index) {
        final data = details.data[index];
        return Container(
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      bottom: 18,
                    ),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(data.icon, size: 32, color: textColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  NumberFormat('#,###').format(data.value),
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserTable(BuildContext context, UsersData details) {
    final minRowCount = 5;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - kToolbarHeight - 350;
    const rowHeight = 56.0;
    var rowCount = (availableHeight / rowHeight).floor().clamp(minRowCount, 999);

    // Fetch only [rowCount] users or slice the list
    final usersToShow = details.data.take(rowCount).toList();

    return Container(
      decoration: BoxDecoration(color: cardBackgroundColor),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const SearchWithBotton(
                searchBgColor: backgroundColor,
                icon: Icons.file_upload,
                btnName: 'Export',
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.people, color: textColor, size: 28),
                  SizedBox(width: 8),
                  Text(
                    'Users Table',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) => ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    columns: _buildColumns(),
                    rows: usersToShow.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user.name)),
                          DataCell(Text(user.mobileNumber)),
                          DataCell(
                            Text(
                              DateFormat('MMM d, yyyy').format(user.birthdate),
                            ),
                          ),
                          DataCell(
                            Text(DateFormat('MMM d, yyyy').format(user.joined)),
                          ),
                          DataCell(
                            Text(NumberFormat('#,###').format(user.points)),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                context.go('/businesses/users/details');
                              },
                              icon: const Icon(
                                Icons.person_outline,
                                color: secondaryColor,
                              ),
                              tooltip: 'User Details',
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28, right: 28),
                    child: _tableControllers(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    const columns = [
      'Name',
      'Mobile Number',
      'Birthdate',
      'Joined',
      'Points',
      'Actions',
    ];
    return columns
        .map((label) => DataColumn(label: Text(label, style: _headerTextStyle)))
        .toList();
  }

  Widget _tableControllers() {
    return Row(
      children: [
        _paginationButton(icon: Icons.chevron_left, onTap: () {}),
        ...List.generate(
          4,
          (i) => _paginationPage(label: '${i + 1}', onTap: () {}),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '...',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _paginationPage(label: '50', onTap: () {}),
        _paginationButton(icon: Icons.chevron_right, onTap: () {}),
      ],
    );
  }

  Widget _paginationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return _paginationContainer(onTap: onTap, child: Icon(icon, size: 20));
  }

  Widget _paginationPage({required String label, required VoidCallback onTap}) {
    return _paginationContainer(
      onTap: onTap,
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }

  Widget _paginationContainer({
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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
