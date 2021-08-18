import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'MovieModel.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String director;

  @HiveField(2)
  String picSt;
}
