import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/quick_links_data.dart';

class QuickLinksWidget extends StatelessWidget {
  const QuickLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final details = QuickLinksData();
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Row(
              children: [
                Icon(Icons.flash_on_outlined, color: textColor, size: 28,),
                SizedBox(width: 8,),
                Text('Quick Links', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(itemCount: details.data.length, itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Row(
                  children: [
                    Icon(details.data[index].icon, color: primaryColor,),
                    SizedBox(width: 12,),
                    Text(details.data[index].title, style: TextStyle(color: primaryColor),)
                  ],
                ),
              );
            },),
          )
        ],
      ),
    );
  }
}
