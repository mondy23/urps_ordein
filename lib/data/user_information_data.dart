import 'package:urps_ordein/models/users_information_model.dart';

class UserInformationData {
  final UsersInformationModel data = UsersInformationModel(
    id: 23,
    name: 'Jane Doe',
    mobileNumber: '09171234567',
    birthdate: DateTime(1990, 5, 15),
    linkedBusiness: 'Doe Enterprises',
    joined: DateTime(2022, 1, 10),
    points: 1500,
  );
}
