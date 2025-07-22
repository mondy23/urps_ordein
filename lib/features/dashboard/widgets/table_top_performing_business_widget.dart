// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:urps_ordein/api/api.dart';
// import 'package:urps_ordein/const/constant.dart';
// import 'package:urps_ordein/models/top_performing_businesses_model.dart';

// class TableTopPerformingBusinessWidget extends ConsumerWidget {
//   const TableTopPerformingBusinessWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final businessesAsync = ref.watch(businessesProvider);
//     return businessesAsync.when(
//       data: (topBusiness) {
//         final sortedTop10 = topBusiness.topBusinesses
//           ..sort(
//             (a, b) => b.pointsIssued.compareTo(a.pointsIssued),
//           ); // descending
//         final top10 = sortedTop10.take(10).toList(); // top 10 only

//         return topBusinesses(top10);
//       },
//       error: (error, stack) => Center(child: Text('❌ Error: $error')),
//       loading: () => const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// Widget topBusinesses(List<TopPerformingBusinessesModel> business) {
//   final headerTextStyle = TextStyle(
//     color: const Color.fromARGB(255, 147, 151, 161),
//     fontSize: 16,
//   );
//   return Container(
//     decoration: BoxDecoration(color: cardBackgroundColor),
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 16, left: 16),
//             child: Row(
//               children: [
//                 Icon(Icons.business, color: textColor, size: 28),
//                 SizedBox(width: 8),
//                 Text(
//                   'Top 10 Performing Businesses',
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),

//           LayoutBuilder(
//             builder: (context, constraints) => ConstrainedBox(
//               constraints: BoxConstraints(minWidth: constraints.maxWidth),
//               child: DataTable(
//                 dividerThickness: 0,
//                 columns: [
//                   DataColumn(
//                     label: Text('Business Name', style: headerTextStyle),
//                   ),
//                   DataColumn(
//                     label: Text('Points Issued', style: headerTextStyle),
//                   ),
//                   DataColumn(label: Text('Users', style: headerTextStyle)),
//                 ],
//                 rows: business.map((b) {
//                   return DataRow(
//                     cells: [
//                       DataCell(
//                         Row(
//                           children: [
//                             Icon(Icons.circle, color: textColor, size: 36),
//                             SizedBox(width: 8),
//                             Text(b.businessName),
//                           ],
//                         ),
//                       ),
//                       DataCell(Text(b.pointsIssued.toString())),
//                       DataCell(Text(b.users.toString())),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
