class BusinessUserLineChart {
  final int totalUsers;
  final Timeframes timeframes;

  BusinessUserLineChart({
    required this.totalUsers,
    required this.timeframes,
  });

  factory BusinessUserLineChart.fromJson(Map<String, dynamic> json) {
    return BusinessUserLineChart(
      totalUsers: json['total_users'] ?? 0,
      timeframes: Timeframes.fromJson(json['timeframes'] ?? {}),
    );
  }

  factory BusinessUserLineChart.empty() {
    return BusinessUserLineChart(
      totalUsers: 0,
      timeframes: Timeframes.empty(),
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
      day: (json['day'] as List?)
              ?.map((x) => DayData.fromJson(x))
              .toList() ??
          [],
      week: (json['week'] as List?)
              ?.map((x) => WeekData.fromJson(x))
              .toList() ??
          [],
      year: (json['year'] as List?)
              ?.map((x) => YearData.fromJson(x))
              .toList() ??
          [],
    );
  }

  factory Timeframes.empty() {
    return Timeframes(
      day: List.generate(7, (i) => DayData(day: i, users: 0)),
      week: List.generate(5, (i) => WeekData(week: i + 1, users: 0)),
      year: List.generate(12, (i) => YearData(month: i, users: 0)),
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
      day: json['day'] ?? 0,
      users: json['users'] ?? 0,
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
      week: json['week'] ?? 1,
      users: json['users'] ?? 0,
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
      month: json['month'] ?? 0,
      users: json['users'] ?? 0,
    );
  }
}
