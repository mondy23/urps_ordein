class UsersModels {
  final int id;
  final String name;
  final String mobileNumber;
  final DateTime birthdate;
  final DateTime joined;
  final int points;

  UsersModels({
    required this.id, 
    required this.name,
    required this.mobileNumber,
    required this.birthdate,
    required this.joined,
    required this.points,
  });
}
