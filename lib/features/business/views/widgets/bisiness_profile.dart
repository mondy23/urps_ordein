import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 475,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Top-right more icon
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(icon: Icon(Icons.more_horiz), color: textColor, onPressed: () {  }),
          ),

          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/ottokonek_logo.jpeg',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ottokonek',
                        style: TextStyle(
                          height: 1,
                          fontSize: 24,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Store',
                        style: TextStyle(
                          height: 1,
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
