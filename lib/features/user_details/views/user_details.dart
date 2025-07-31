import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';
import 'package:urps_ordein/features/user_details/views/widgets/circle_percent.dart';
import 'package:urps_ordein/features/user_details/views/widgets/info_card.dart';
import 'package:urps_ordein/features/user_details/views/widgets/points_line_chart.dart';
import 'package:urps_ordein/features/user_details/views/widgets/redemption.dart';
import 'package:urps_ordein/features/user_details/views/widgets/transaction.dart';

class UserDetails extends ConsumerWidget {

  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDetailsProvider);
    final currentPage = ref.watch(offsetProvider);
    // final limit = ref.watch(limitProvider);
    return user.when(
      data: (u) {
        return Column(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  Expanded(flex: 2, child: PointsLineChart()),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(flex: 3, child: CirclePercent()),
                        Expanded(child: InfoCard()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(child: Transaction()),
                  Expanded(child: Redemption()),
                ],
              ),
            )
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