class BusinessUserLineChart {
  final int totalUsers;
  final Timeframes timeframes;

  BusinessUserLineChart({
    required this.totalUsers,
    required this.timeframes,
  });

  factory BusinessUserLineChart.fromJson(Map<String, dynamic> json) {
    return BusinessUserLineChart(
      totalUsers: json['total_users'],
      timeframes: Timeframes.fromJson(json['timeframes']),
    );
  }
}

class Timeframes {
  final List<DayData> day;
  final List<WeekData> week;
  final List<YearData> year;

  Timeframes({
    required this.day,
    required this.week,
    required this.year,
  });

  factory Timeframes.fromJson(Map<String, dynamic> json) {
    return Timeframes(
      day: List<DayData>.from(json['day'].map((x) => DayData.fromJson(x))),
      week: List<WeekData>.from(json['week'].map((x) => WeekData.fromJson(x))),
      year: List<YearData>.from(json['year'].map((x) => YearData.fromJson(x))),
    );
  }
}

class DayData {
  final int day;
  final int users;

  DayData({
    required this.day,
    required this.users,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      day: json['day'],
      users: json['users'],
    );
  }
}

class WeekData {
  final int week;
  final int users;

  WeekData({
    required this.week,
    required this.users,
  });

  factory WeekData.fromJson(Map<String, dynamic> json) {
    return WeekData(
      week: json['week'],
      users: json['users'],
    );
  }
}

class YearData {
  final int month;
  final int users;

  YearData({
    required this.month,
    required this.users,
  });

  factory YearData.fromJson(Map<String, dynamic> json) {
    return YearData(
      month: json['month'],
      users: json['users'],
    );
  }
}
