import 'package:hive_flutter/adapters.dart';

part 'rating_entity.g.dart';

@HiveType(typeId: 2)
class RatingEntity {
  @HiveField(0)
  final dynamic rate;

  @HiveField(1)
  final int count;

  RatingEntity({required this.rate, required this.count});

  factory RatingEntity.fromJSON(Map<String, dynamic> json) {
    return RatingEntity(rate: json['rate'], count: json['count']);
  }
}
