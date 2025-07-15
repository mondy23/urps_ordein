class UsersInformationModel {
  final int id;
  final String name;
  final String mobileNumber;
  final DateTime birthdate;
  final String linkedBusiness;
  final DateTime joined;
  final int points;

  UsersInformationModel({
    required this.id, 
    required this.name,
    required this.mobileNumber,
    required this.birthdate,
    required this.linkedBusiness, 
    required this.joined,
    required this.points,
  });
}
