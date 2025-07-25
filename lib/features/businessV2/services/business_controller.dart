

import 'package:urps_ordein/api/api.dart';
import 'package:urps_ordein/features/business/model/business_model.dart';

final businessCrudService = APIService<BusinessModel>(
  endpoint: "/api/private/v1/businesses",
  fromJson: (json) => BusinessModel.fromJson(json),
  toJson: (model) => model.toJson(),
);
