import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/pages/businesses/widgets/page_business_table.dart';
import 'package:urps_ordein/widgets/search_with_botton.dart';

class Business extends StatelessWidget {
  const Business({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 0, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      child: SearchWithBotton(
                        searchBgColor: backgroundColor,
                        icon: Icons.add,
                        btnName: 'Create Business',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Row(
                        children: [
                          Icon(Icons.business, color: textColor, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            'Businesses',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                 
                        BusinessDataTable(),
                  
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}