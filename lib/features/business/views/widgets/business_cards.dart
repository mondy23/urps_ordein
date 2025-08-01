  import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/data/user_cards_data.dart';

Widget BuildUserCards(UserCardsData details) {
    return GridView.builder(
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        mainAxisExtent: 160,
      ),
      itemBuilder: (context, index) {
        final data = details.data[index];
        return CustomContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, bottom: 18),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(data.icon, size: 32, color: textColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  NumberFormat('#,###').format(data.value),
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
