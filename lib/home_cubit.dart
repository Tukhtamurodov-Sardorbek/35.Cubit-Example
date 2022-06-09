import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

// We need to pick random names
const names = [
  'BLoC',
  'Cubit',
  'GetX',
  'Provider',
  'Scoped Model',
  'MobX',
  'Stacked',
];

// We need to pick random names
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

// Cubit class definition
class NameCubit extends Cubit<String?> {
  // Constructor of the cubit
  NameCubit() : super(null);

  // Allow picking random names in the cubit
  void pickRandomName() => emit(names.getRandomElement());
}