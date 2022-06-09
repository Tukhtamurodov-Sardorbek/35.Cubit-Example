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
  // Cubit & BLoC need an initial state
  // The reason why we used nullable String is that we don't know what value
  // this cubit is gonna start with
  // What we wanna do is to expose a function on this cubit that will generate
  // a random name but initially it has NO random name => so it is just gonna
  // wait for us to ask for a random name

  // * However it doesn't have to be like this, we could go ahead and write
  //                 class NameCubit extends Cubit<String>
  //                   NameCubit() : super('Some name');
  // So we just pick a random name, however this doesn't come from our list of
  // random names

  // * So we could go ahead and say our cubit of String, but for us we're just
  // gonna go ahead with a cubit of nullable String and then say we don't
  // initially have a value to produce
  NameCubit() : super(null);

  // Allow picking random names in the cubit
  // We wanna produce a state =>
  // Every cubit & BLoC has a special object called State
  // If, for instance, type the following
  //
  // void pickRandomName(){
  //   state = 'Random name';
  // }
  // The state gives the current state of our cubit
  // And in our case, after the CONSTRUCTION of NAMECUBIT, which has null value,
  // this state is gonna be null. However, we can produce new state, we're not
  // gonna set new value for this, because of the type of state, it's a getter
  // So we can only read state, but how do we actually produce a new state?
  // Through a function called emit!
  // There is a function in both BLoC and Cubit called emit
  // emit - is our way of producing new values both from our bloc and cubit
  void pickRandomName() => emit(names.getRandomElement());
}