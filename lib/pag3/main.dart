import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp1(),
  );
}

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    value -= 1;
    notifyListeners();
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Consumer<Counter>(
              builder: (context, counter, child) => Text('${counter.value}',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            const SizedBox(height: 20),
            Consumer<Counter>(
              builder: (context, counter, child) {
                List<Widget> dotWidgets = [];

                for (int i = 0; i < counter.value.abs(); i++) {
                  dotWidgets.add(
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: counter.value >= 0 ? Colors.blue : Colors.red,
                      ),
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dotWidgets,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Provider.of<Counter>(context, listen: false).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 20), // Espacio entre los botones flotantes
          FloatingActionButton(
            onPressed: () {
              Provider.of<Counter>(context, listen: false).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
