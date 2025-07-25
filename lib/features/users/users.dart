import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/user_cards_data.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';
import 'package:urps_ordein/features/users/model/user_model.dart';
import 'package:urps_ordein/features/users/provider/users_provider.dart';

class Users extends ConsumerStatefulWidget {
  final int businessID;
  const Users({super.key, required this.businessID});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  static const int rowsPerPage = 5;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final cardsData = UserCardsData();
    final userAsyncValue = ref.watch(usersProvider(widget.businessID));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          SizedBox(height: 160, child: _buildUserCards(cardsData)),
          Expanded(
            child: userAsyncValue.when(
              data: (users) => _buildUserTable(context, users),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text('No data found')),
            ),
          ),
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
                    padding: const EdgeInsets.only(left: 16, top: 16, bottom: 18),
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

  Widget _buildUserTable(BuildContext context, List<UserModel> users) {
    final int totalUsers = users.length;
    final int totalPages = (totalUsers / rowsPerPage).ceil();

    final int start = _currentPage * rowsPerPage;
    final int end = ((_currentPage + 1) * rowsPerPage).clamp(0, totalUsers);
    final usersToShow = users.sublist(start, end);

    return Container(
      decoration: const BoxDecoration(color: cardBackgroundColor),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Row(
                children: [
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
                          DataCell(Text(user.accountIdentifier)),
                          DataCell(Text(
                            user.createdAt != null
                                ? DateFormat('MMM d, yyyy').format(user.createdAt!)
                                : '—',
                          )),
                          DataCell(Text(NumberFormat('#,###').format(user.totalPoints))),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                ref.read(userIDProvider.notifier).state = user.accountIdentifier;
                                context.go('/businesses/${widget.businessID}/users/${user.accountIdentifier}/details');
                              },
                              icon: const Icon(Icons.person_outline, color: secondaryColor),
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
                    child: _buildPaginationControls(totalPages),
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
    const columns = ['ID', 'Joined', 'Points', 'Actions'];
    return columns
        .map((label) => DataColumn(label: Text(label, style: _headerTextStyle)))
        .toList();
  }

  Widget _buildPaginationControls(int totalPages) {
    return Row(
      children: [
        _paginationButton(
          icon: Icons.chevron_left,
          onTap: _currentPage > 0
              ? () => setState(() => _currentPage--)
              : null,
        ),
        ...List.generate(totalPages, (index) {
          return _paginationPage(
            label: '${index + 1}',
            isActive: index == _currentPage,
            onTap: () => setState(() => _currentPage = index),
          );
        }),
        _paginationButton(
          icon: Icons.chevron_right,
          onTap: _currentPage < totalPages - 1
              ? () => setState(() => _currentPage++)
              : null,
        ),
      ],
    );
  }

  Widget _paginationButton({required IconData icon, VoidCallback? onTap}) {
    return _paginationContainer(
      onTap: onTap,
      child: Icon(icon, size: 20),
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
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? primaryColor : null,
        ),
      ),
    );
  }

  Widget _paginationContainer({
    required Widget child,
    VoidCallback? onTap,
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
            width: 32,
            height: 32,
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

  static const _headerTextStyle = TextStyle(
    color: Color.fromARGB(255, 147, 151, 161),
    fontSize: 16,
  );
}
