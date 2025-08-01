import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';
import 'package:urps_ordein/widgets/error_no_data.dart';

class Redemption extends ConsumerWidget {
  final String userID;
  final int businessID;
  const Redemption({super.key, required this.userID, required this.businessID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redemptions = ref.watch(getRedemption((1, 5, userID, businessID)));
    return redemptions.when(
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
                      'Redemption',
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
                            ).format(data.records[index].redemptionTime),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: textColor,
                            ),
                          ),

                          Text(
                            '-${data.records[index].pointsRedeemed}pts',
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
