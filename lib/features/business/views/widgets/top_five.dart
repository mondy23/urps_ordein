import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class TopFive extends StatelessWidget {
  const TopFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 475,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top 5',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Text(
                '#111',
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Image.asset('assets/images/rank1.png', width: 50, height: 50),
            ],
          ),
          SizedBox(height: 27),
          Row(
            children: [
              Text(
                '#222',
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Image.asset('assets/images/rank2.png', width: 50, height: 50),
            ],
          ),
          SizedBox(height: 27),
          Row(
            children: [
              Text(
                '#333',
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Image.asset('assets/images/rank3.png', width: 50, height: 50),
            ],
          ),
          SizedBox(height: 27),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Text(
                  '#444',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '4',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Text(
                  '#555',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '5',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
