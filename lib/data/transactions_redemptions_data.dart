import 'package:urps_ordein/models/transactions_redemptions_model.dart';

class TransactionsData {
  final List<TransactionsModel> data = [
    TransactionsModel(
      dateAndTime: DateTime(2024, 4, 1),
      description: 'Purchase at ABC Store',
      earn: 50,
    ),
    TransactionsModel(
      dateAndTime: DateTime(2024, 4, 1),
      description: 'Coffee Shop Points',
      earn: 20,
    ),
    TransactionsModel(
      dateAndTime: DateTime(2024, 4, 1),
      description: 'Referral Bonus',
      earn: 100,
    ),
    TransactionsModel(
      dateAndTime: DateTime(2024, 4, 1),
      description: 'Points Redemption',
      earn: -30,
    ),
    TransactionsModel(
      dateAndTime: DateTime(2024, 4, 1),
      description: 'Grocery Purchase',
      earn: 40,
    ),
  ];
}

class RedemptionsData {
  final List<RedemptionsModel> data = [
    RedemptionsModel(
      dateAndTime: DateTime(2025, 7, 9, 10, 00),
      description: 'Used points at Coffee Shop',
      redeemed: 20,
    ),
    RedemptionsModel(
      dateAndTime: DateTime(2025, 7, 8, 14, 30),
      description: 'Redeemed Gift Card',
      redeemed: 100,
    ),
    RedemptionsModel(
      dateAndTime: DateTime(2025, 7, 7, 16, 45),
      description: 'Discount on Electronics',
      redeemed: 75,
    ),
    RedemptionsModel(
      dateAndTime: DateTime(2025, 7, 6, 12, 15),
      description: 'Movie Ticket Redemption',
      redeemed: 50,
    ),
  ];
}