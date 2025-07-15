import 'package:flutter/material.dart';
import 'package:urps_ordein/models/user_card_models.dart';

class UserCardsData {
  final data = <UserCardModels>[
    UserCardModels(icon: Icons.people_rounded, title: 'Total Users', value: 245),
    UserCardModels(icon: Icons.transfer_within_a_station_rounded, title: 'Total Points Issued', value: 12400),
    UserCardModels(icon: Icons.redeem_rounded, title: 'Total Points Redeemed', value: 4500)
  ];
}