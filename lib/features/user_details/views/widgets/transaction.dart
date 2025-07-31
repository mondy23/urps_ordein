import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';
import 'package:urps_ordein/widgets/error_no_data.dart';

class Transaction extends ConsumerWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(getTransactions((1, 5)));
    return transactions.when(
      data: (data) {
        if (data == null) {
          return ErrorNoData();
        }
        return CustomContainer(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Use Expanded here, after Padding
                Expanded(
                  child: ListView.builder(
                    itemCount: data.records.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'MMM d, yyyy',
                            ).format(data!.records[index].transactionTime),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: textColor,
                            ),
                          ),

                          Text(
                            data.records[index].amount.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '+${data.records[index].pointsEarned}pts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Center(child: Text('No data found')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
