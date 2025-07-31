import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';

class InfoCard extends ConsumerWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(userIDProvider);
    final businessName = ref.watch(businessNameProvider);
    return CustomContainer(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Image.asset('assets/images/ottokonek_logo.jpeg', fit: BoxFit.contain,)),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(businessName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),),
                Text('UID: $userID', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: textColor),),
              ],
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_back_ios, color: textColor, size: 28,),
          SizedBox(width: 16,)
        ],
      ),
    );
  }
}
