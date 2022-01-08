import 'package:uuid/uuid.dart';

class RandomID {
  static String get getRandom {
    const uuid = Uuid();
    return uuid.v1();
  }
}
