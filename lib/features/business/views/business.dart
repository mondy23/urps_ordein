import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/features/business/controllers/users_provider.dart';
import 'package:urps_ordein/features/business/views/widgets/bisiness_profile.dart';
import 'package:urps_ordein/features/business/views/widgets/top_five.dart';
import 'package:urps_ordein/features/business/views/widgets/business_line_chart.dart';
import 'package:urps_ordein/features/business/views/widgets/users_table.dart';

class Business extends ConsumerWidget {
  final int businessId;
  const Business({super.key, required this.businessId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow1(context, ref, businessId),
          const SizedBox(height: 24),
          _buildRow2(),
          const SizedBox(height: 24),
          _buildRow3(),
        ],
      ),
    );
  }

 Widget _buildRow1(BuildContext context, WidgetRef ref, int businessID) {
  final summaryAsync = ref.watch(businessSummaryProvider(businessID));

  return summaryAsync.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, stack) => Text('Error: $error'),
    data: (summary) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Total Rewards',
                    '${summary.thisMonthTotalRewards} pts',
                    _formatChange(summary.percentChangeTotal),
                    'vs Lastmonth',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildMetricCard(
                    'Total Earned',
                    '${summary.thisMonthEarned}',
                    _formatChange(summary.percentChangeEarned),
                    'vs Lastmonth',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildMetricCard(
              'Total Redemption',
              '${summary.thisMonthRedeemed}',
              _formatChange(summary.percentChangeRedeemed),
              'vs Lastmonth',
            ),
          ),
        ],
      );
    },
  );
}


  Widget _buildRow2() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: BusinessLineChart(businessID: businessId)),
        const SizedBox(width: 24),
        Expanded(flex: 1, child: BusinessProfile()),
      ],
    );
  }

  Widget _buildRow3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: TopFive()),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: UsersTable(businessID: businessId,)),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String change,
    String subtitle,
  ) {
    final bool isIncrease = change.contains('↑');
    final Color changeColor = isIncrease ? primaryColor : Colors.red;

    return Container(
      height: 156,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Row(
            children: [
              Text(
                change,
                style: TextStyle(
                  color: changeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatChange(int? percent) {
  if (percent == null) return '-';
  final symbol = percent >= 0 ? '↑' : '↓';
  return '$symbol ${percent.abs()}%';
}

}
