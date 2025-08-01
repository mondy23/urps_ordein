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

  factory BusinessSummary.fromJson(Map<String, dynamic> json) {
    return BusinessSummary(
      businessID: json['BusinessID'],
      thisMonthEarned: json['ThisMonthEarned'],
      thisMonthRedeemed: json['ThisMonthRedeemed'],
      thisMonthTotalRewards: json['ThisMonthTotalRewards'],
      lastMonthEarned: json['LastMonthEarned'],
      lastMonthRedeemed: json['LastMonthRedeemed'],
      lastMonthTotalRewards: json['LastMonthTotalRewards'],
      percentChangeEarned: json['PercentChangeEarned'],
      percentChangeRedeemed: json['PercentChangeRedeemed'],
      percentChangeTotal: json['PercentChangeTotal'],
    );
  }

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
