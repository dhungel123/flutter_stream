import 'dart:async';

import 'package:flutter/material.dart';

class BroadCastStream extends StatefulWidget {
  const BroadCastStream({Key? key}) : super(key: key);

  @override
  State<BroadCastStream> createState() => _BroadCastStreamState();
}

class _BroadCastStreamState extends State<BroadCastStream> {

  final StreamController<int> controller  =   StreamController<int>.broadcast();

  @override
  void initState() {

    super.initState();
    broadCastStream();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast stream '),centerTitle: true,),
      body: ListView(
        children: [
          StreamBuilder(
            stream: controller.stream,
            builder: (BuildContext context,AsyncSnapshot<int> snapshot){
              if(snapshot.hasData){
                final data=snapshot.data!;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Listen 1: $data'),
                      SizedBox(height: 16,),
                      Text('Listen 2: $data'),

                    ],
                  ),
                );
              }
              else{
                return Text('no data');
              }
            },
          )
        ],
      ),
    );
  }

  void broadCastStream() {

    //Multiple subscription (broadcast) stream
    final Stream<int> broadcastStream=controller.stream.asBroadcastStream();

    // Listener 1
    final StreamSubscription<int> subscription1=broadcastStream.listen((event) {
      print('Listen 1:$event');
    });

    // Listen 2
    final StreamSubscription<int> subscription2=broadcastStream.listen((event) {
      print('Listen 2: $event');
    });

    Future.delayed(const Duration(seconds: 1),(){
      controller.sink.add(1);

    });
    Future.delayed(Duration(seconds: 3),(){

    });



  }
}
