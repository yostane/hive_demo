import 'dart:math';

import 'package:hive/hive.dart';
import 'package:hive_demo/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  static final _usersTable = "users";

  static Future<void> setupDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  static Future<void> addRandomUser() async {
    final box = await Hive.openBox<User>(_usersTable);
    const names = ["Garrus", "Cloud", "Sangoku"];
    final r = Random();
    final name = names[r.nextInt(names.length)];
    final age = r.nextInt(100);
    await box.add(User(name, age));
  }

  static Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox<User>(_usersTable);
    return box.values.toList();
  }
}
