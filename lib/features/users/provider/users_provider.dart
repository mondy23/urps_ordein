import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/api/api.dart';
import 'package:urps_ordein/features/users/model/user_model.dart';

final usersProvider = FutureProvider.family<List<UserModel>, int>((ref, businessID) async {
  final service = APIService<UserModel>(
    endpoint: "/api/private/v1/businesses/$businessID/users",
    fromJson: (json) => UserModel.fromJson(json),
    toJson: (model) => model.toJson(),
  );
  return service.getListAll(1, 100); // Get page 1, max 100 users (adjust as needed)
});
