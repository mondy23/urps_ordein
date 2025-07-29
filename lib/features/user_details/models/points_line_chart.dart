class PointsLineChartResponse {
  final Timeframes timeframes;
  final int totalPoints;

  PointsLineChartResponse({required this.timeframes, required this.totalPoints});

  factory PointsLineChartResponse.fromJson(Map<String, dynamic> json) {
    return PointsLineChartResponse(
      totalPoints: json['total_points'],
      timeframes: Timeframes.fromJson(json['timeframes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_points': totalPoints,
      'timeframes': timeframes.toJson(),
    };
  }
}

class Timeframes {
  final List<TimeframeDay> day;
  final List<TimeframeWeek> week;
  final List<TimeframeYear> year;

  Timeframes({required this.day, required this.week, required this.year});

  factory Timeframes.fromJson(Map<String, dynamic> json) {
    return Timeframes(
      day: (json['day'] as List)
          .map((e) => TimeframeDay.fromJson(e))
          .toList(),
      week: (json['week'] as List)
          .map((e) => TimeframeWeek.fromJson(e))
          .toList(),
      year: (json['year'] as List)
          .map((e) => TimeframeYear.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day.map((e) => e.toJson()).toList(),
      'week': week.map((e) => e.toJson()).toList(),
      'year': year.map((e) => e.toJson()).toList(),
    };
  }
}

class TimeframeDay {
  final int day;
  final int points;

  TimeframeDay({required this.day, required this.points});

  factory TimeframeDay.fromJson(Map<String, dynamic> json) {
    return TimeframeDay(
      day: json['day'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'points': points,
    };
  }
}

class TimeframeWeek {
  final int week;
  final int points;

  TimeframeWeek({required this.week, required this.points});

  factory TimeframeWeek.fromJson(Map<String, dynamic> json) {
    return TimeframeWeek(
      week: json['week'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'points': points,
    };
  }
}

class TimeframeYear {
  final int month;
  final int points;

  TimeframeYear({required this.month, required this.points});

  factory TimeframeYear.fromJson(Map<String, dynamic> json) {
    return TimeframeYear(
      month: json['month'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'points': points,
    };
  }
}
