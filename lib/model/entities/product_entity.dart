import 'package:hive_flutter/adapters.dart';
import 'package:p1_mobile_app/model/entities/rating_entity.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 1)
class ProductEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final dynamic price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final RatingEntity rating;

  ProductEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.rating});

  factory ProductEntity.fromJSON(Map<String, dynamic> json) {
    return ProductEntity(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        image: json['image'],
        rating: RatingEntity.fromJSON(json['rating']));
  }
}
