import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text('Ottokonek', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),),
                Text('UID: 1111', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: textColor),),
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
