class TransactionModel {
  final int transactionID;
  final String accountIdentifier;
  final int pointsEarned;
  final DateTime transactionTime;

  TransactionModel({
    required this.transactionID,
    required this.accountIdentifier,
    required this.pointsEarned,
    required this.transactionTime,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionID: json['transaction_id'] as int? ?? 0,
      accountIdentifier: json['account_identifier'] as String? ?? '',
      pointsEarned: json['points_earned'] as int? ?? 0,
      transactionTime: DateTime.tryParse(json['transaction_time'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionID,
        'account_identifier': accountIdentifier,
        'points_earned': pointsEarned,
        'transaction_time': transactionTime.toIso8601String(),
      };
}

class TransactionResponse {
  final int transactionCount;
  final List<TransactionModel> transactions;

  TransactionResponse({
    required this.transactionCount,
    required this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return TransactionResponse.empty();

    final txList = json['transactions'];
    return TransactionResponse(
      transactionCount: json['total'] as int? ?? 0,
      transactions: txList is List
          ? txList.map((t) => TransactionModel.fromJson(t)).toList()
          : [],
    );
  }

  factory TransactionResponse.empty() {
    return TransactionResponse(
      transactionCount: 0,
      transactions: [],
    );
  }
}
