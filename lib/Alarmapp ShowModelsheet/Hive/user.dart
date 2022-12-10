import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  String? data;
  @HiveField(1)
  bool? isRepeating;
  User({this.data, this.isRepeating});
}