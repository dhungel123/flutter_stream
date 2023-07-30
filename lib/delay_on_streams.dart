import 'dart:async';

import 'package:flutter/material.dart';

class DelayOnStream extends StatelessWidget {
  DelayOnStream({Key? key}) : super(key: key);
  ///A StreamController in Dart is a class that provides a way to produce and listen to streams.
  /// It acts as both a stream sink (where data can be added to the stream)
  /// and a stream (where listeners can listen for data events).
  final StreamController<int> _controller=StreamController<int>();


  @override
  Widget build(BuildContext context) {
   // delayedNumberStream();
    return Scaffold(
      body: ListView(
        children: [

          Text('Upper Stream Builder'),
          StreamBuilder(
            stream: delayedNumberStream(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              if(snapshot.hasData){
                return Text('THe number are:${snapshot.data}',textScaleFactor: 2,);
              }
              else if(snapshot.hasError){
                return Text('Error:${snapshot.error}');
              }
              else{
                return CircularProgressIndicator();
              }


              }
              ),

          SizedBox(height: 12,),

          Text('Lower Stream Builder'),

          StreamBuilder(
              stream: delayedNumberStream(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                if(snapshot.hasData){
                  return Text('THe number are:${snapshot.data}',textScaleFactor: 2,);
                }
                else if(snapshot.hasError){
                  return Text('Error:${snapshot.error}');
                }
                else{
                  return CircularProgressIndicator();
                }


              }
          )

        ],

      ),

    );
  }
  // Future<void> startEmittingNumbers() async {
  //   for(int i=1;i<=12;i++){
  //     await Future.delayed(const Duration(seconds: 1));
  //     _controller.add(i);
  //   }
  //   _controller.close();
  // }
  Stream<int> delayedNumberStream() async* {
    for(int i=1;i<12;i++){
      await Future.delayed(Duration(seconds: 1));
      yield i;

    }
  }
}
