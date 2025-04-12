import 'package:collection/collection.dart';

enum GoalPrayer {
  goal,
  prayer,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (GoalPrayer):
      return GoalPrayer.values.deserialize(value) as T?;
    default:
      return null;
  }
}
