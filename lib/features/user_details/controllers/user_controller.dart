import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/features/user_details/models/response_model.dart';
import 'package:urps_ordein/features/user_details/services/user_services.dart';


final userIDProvider = StateProvider<String>((ref) => '1');
final businessIDProvider = StateProvider<int>((ref) => 1);

final limitProvider = StateProvider<int>((ref) => 4);
final offsetProvider = StateProvider<int>((ref) => 5);


final userServiceProvider = Provider((ref) => UserServices());

final userDetailsProvider = FutureProvider<UserDetailsResponseModel?>((ref) async {
  final service = ref.read(userServiceProvider);        
  final userID = ref.watch(userIDProvider);             
  final businessID = ref.watch(businessIDProvider);    
  final limit = ref.watch(limitProvider); 
  final offset = ref.watch(offsetProvider);
  return service.getUserDetails(businessID, userID, limit, offset-1);    
});
