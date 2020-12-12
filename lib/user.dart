import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User(this.name, this.age);

  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
}
