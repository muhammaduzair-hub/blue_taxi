
import 'package:bluetaxiapp/provider_practice/provider/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Screen"),
      ),
      body: Center(
        child: Consumer<CounterState>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                "${value.counter}",
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                  onPressed: () {
                    //It is same as Provider.of<T> but listen is true, then why it is working
                    value.counterIncrement();
                    // Provider.of<CounterState>(context).counterIncrement(); //by default listen is true
                  },
                  child: Text("test"))
            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterState>(context, listen: false)
            .counterIncrement(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
