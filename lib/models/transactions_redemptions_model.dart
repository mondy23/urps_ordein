class TransactionsModel {
  final DateTime dateAndTime;
  final String description;
  final int earn;

  TransactionsModel({required this.dateAndTime, required this.description, required this.earn});
}

class RedemptionsModel {
  final DateTime dateAndTime;
  final String description;
  final int redeemed;

  RedemptionsModel({required this.dateAndTime, required this.description, required this.redeemed});
}