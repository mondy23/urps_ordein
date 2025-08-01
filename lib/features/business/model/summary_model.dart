class BusinessSummary {
  final int businessID;
  final int thisMonthEarned;
  final int thisMonthRedeemed;
  final int thisMonthTotalRewards;
  final int lastMonthEarned;
  final int lastMonthRedeemed;
  final int lastMonthTotalRewards;
  final int percentChangeEarned;
  final int percentChangeRedeemed;
  final int percentChangeTotal;

  BusinessSummary({
    required this.businessID,
    required this.thisMonthEarned,
    required this.thisMonthRedeemed,
    required this.thisMonthTotalRewards,
    required this.lastMonthEarned,
    required this.lastMonthRedeemed,
    required this.lastMonthTotalRewards,
    required this.percentChangeEarned,
    required this.percentChangeRedeemed,
    required this.percentChangeTotal,
  });

  /// Creates a [BusinessSummary] with all values set to zero.
  factory BusinessSummary.empty(int businessID) {
    return BusinessSummary(
      businessID: businessID,
      thisMonthEarned: 0,
      thisMonthRedeemed: 0,
      thisMonthTotalRewards: 0,
      lastMonthEarned: 0,
      lastMonthRedeemed: 0,
      lastMonthTotalRewards: 0,
      percentChangeEarned: 0,
      percentChangeRedeemed: 0,
      percentChangeTotal: 0,
    );
  }

  /// Parses from JSON, with null-safety and fallbacks.
  factory BusinessSummary.fromJson(Map<String, dynamic> json) {
    return BusinessSummary(
      businessID: json['BusinessID'] ?? 0,
      thisMonthEarned: json['ThisMonthEarned'] ?? 0,
      thisMonthRedeemed: json['ThisMonthRedeemed'] ?? 0,
      thisMonthTotalRewards: json['ThisMonthTotalRewards'] ?? 0,
      lastMonthEarned: json['LastMonthEarned'] ?? 0,
      lastMonthRedeemed: json['LastMonthRedeemed'] ?? 0,
      lastMonthTotalRewards: json['LastMonthTotalRewards'] ?? 0,
      percentChangeEarned: json['PercentChangeEarned'] ?? 0,
      percentChangeRedeemed: json['PercentChangeRedeemed'] ?? 0,
      percentChangeTotal: json['PercentChangeTotal'] ?? 0,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'BusinessID': businessID,
      'ThisMonthEarned': thisMonthEarned,
      'ThisMonthRedeemed': thisMonthRedeemed,
      'ThisMonthTotalRewards': thisMonthTotalRewards,
      'LastMonthEarned': lastMonthEarned,
      'LastMonthRedeemed': lastMonthRedeemed,
      'LastMonthTotalRewards': lastMonthTotalRewards,
      'PercentChangeEarned': percentChangeEarned,
      'PercentChangeRedeemed': percentChangeRedeemed,
      'PercentChangeTotal': percentChangeTotal,
    };
  }
}
