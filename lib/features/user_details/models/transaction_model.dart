class TransactionModel {
  final int transactionId;
  final String accountIdentifier;
  final int? amount;
  final int businessId;
  final double pointsEarned;
  final String status;
  final DateTime transactionTime;

  TransactionModel({
    required this.transactionId,
    required this.accountIdentifier,
    required this.amount,
    required this.businessId,
    required this.pointsEarned,
    required this.status,
    required this.transactionTime,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transaction_id'],
      accountIdentifier: json['account_identifier'],
      amount: json['amount'],
      businessId: json['business_id'],
      pointsEarned: (json['points_earned'] as num).toDouble(),
      status: json['status'],
      transactionTime: DateTime.parse(json['transaction_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'account_identifier': accountIdentifier,
      'amount': amount,
      'business_id': businessId,
      'points_earned': pointsEarned,
      'status': status,
      'transaction_time': transactionTime.toIso8601String(),
    };
  }
}

class TransactionResponse {
  final int currentPage;
  final List<TransactionModel> records;
  final int totalCount;
  final int totalPages;

  TransactionResponse({
    required this.currentPage,
    required this.records,
    required this.totalCount,
    required this.totalPages,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      currentPage: json['currentPage'],
      records: (json['records'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'records': records.map((e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }
}
