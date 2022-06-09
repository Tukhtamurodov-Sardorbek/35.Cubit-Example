import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define a cubit
  late final NameCubit cubit;

  @override
  void initState() {
    // Initialize our cubit
    cubit = NameCubit();
    super.initState();
  }

  @override
  void dispose() {
    // Close our cubit
    cubit.close();
    super.dispose();
  }

  // As cubit's internal state changes we need to update our homepage's state =>
  // Use StreamBuilder managing value of nullable String just like our cubit!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cubit Example',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          final button = Center(
            child: TextButton(
              onPressed: cubit.pickRandomName,
              child: const Text(
                'Pick a random State Management',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: CupertinoColors.systemBlue,
                  decoration: TextDecoration.underline,
                  decorationColor: CupertinoColors.systemBlue,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
          );

          // So now we have the button we should go ahead and handle various
          // states of the snapshot
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ConnectionState is none',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    button,
                  ],
                ),
              );
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ConnectionState is waiting',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    button,
                  ],
                ),
              );
            case ConnectionState.active:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ConnectionState is active',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    button,
                    const SizedBox(height: 15.0),
                    Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                  ],
                ),
              );
            case ConnectionState.done:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
