import 'dart:async';

import 'package:flutter/material.dart';

class SingleStream extends StatefulWidget {
  const SingleStream({Key? key}) : super(key: key);

  @override
  State<SingleStream> createState() => _SingleStreamState();
}

class _SingleStreamState extends State<SingleStream> {

  // 1. decleare a stream controller
  final StreamController<int> controller = StreamController<int>();

  // 2. Create object of StreamSubscription
  StreamSubscription<int>? _subscription;

  List<int> data = [];

  @override
  void initState() {
    super.initState();
    loadStream();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    controller.close();
    super.dispose();
  }

  void loadStream() {
    // Single subscription stream
    final Stream<int> singleSubscriptionStream = controller.stream;

    // Listerner 1
    _subscription = singleSubscriptionStream.listen(
            (value) {
          print("listener value: $value");
          setState(() {
            data.add(value);
          });
        }
    );
    controller.sink.add(1);

    Future.delayed(const Duration(seconds: 1),(){
      controller.sink.add(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Single stream Exapmle'),centerTitle: true,),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text('Listener ${index+1}: ${data[index]}'),
          );
        }
      )
    );
  }
}

