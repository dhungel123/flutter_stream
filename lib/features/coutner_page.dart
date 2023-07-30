import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// stream saga kam garnu paro vane rxdart vanne packaage use garne
class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  // Create a behaviourSubject to handel our counter state
  final BehaviorSubject<int> _counterSubject=BehaviorSubject<int>.seeded(0);

  Stream<int> get _counterStream=>_counterSubject.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counterSubject.close();

  }

  void _incrementCounter(){
    _counterSubject.add(_counterSubject.value+1);
  }
  void _resetCoutner(){
    //_counterSubject.add()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: [
          StreamBuilder<int>(
            stream: _counterStream,
            builder: (BuildContext context,AsyncSnapshot<int> snapshot){
              if(snapshot.hasData){
                final data=snapshot.data!;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Counter Value: $data'),


                    ],
                  ),
                );
              }
              else{
                return Text('no data');
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: _incrementCounter,
              child: Text('Increment')
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: _resetCoutner, child: Text('Reset')
          )
        ],
      ),
    );
  }
}
