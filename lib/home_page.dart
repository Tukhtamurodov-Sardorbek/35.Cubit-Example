import 'package:cubit_example/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// * Cubits are one layer above from Streams and StreamControllers
// * When we create a cubit we also make sure we dispose it
// * So we need to use StatefulWidget so that we could initialize our cubit
//   and also could dispose it
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

  // * As cubit's internal state changes we need to update our homepage's state =>
  //   Use StreamBuilder managing value of nullable String just like our cubit!
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
        // * We see the cubit is actually exposing a stream of its state,
        //   which is that stream of stream
        stream: cubit.stream,
        builder: (context, snapshot) {
          // * Create a button here, which will call the pickRandomName
          //   on our cubit and it will ask the cubit to produce a new value upon
          //   which the stream of the cubit will produce a new value and it will
          //   come to our builder again
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

          // * So now we have the button we should go ahead and handle various
          //   states of the snapshot
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
              // * In case our cubit is active and it's like actively producing
              //   values or is at least ready to produce new values => we're
              //   gonna create column in here that displays both button and the
              //   text that is produced by the cubit
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
              // * We should never get here because the stream of our cubit
              //   shouldn't complete or shouldn't be done until our homepage's
              //   statefulWidget has actually been disposed!
              //   So we're just putting a sizedBox in here
              return const SizedBox();
          }
        },
      ),
    );
  }
}
