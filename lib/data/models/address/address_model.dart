import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  late String addressName;

  @HiveField(1)
  late String addressType;

  @HiveField(2)
  late DateTime createdDate;

  @HiveField(3)
  late double latitude;

  @HiveField(4)
  late double longtitude;
}
