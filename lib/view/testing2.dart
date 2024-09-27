import 'package:flutter/material.dart';
import 'dart:isolate';

class Testing2 extends StatefulWidget {
  const Testing2({super.key});

  @override
  State<Testing2> createState() => _Testing2State();
}

class _Testing2State extends State<Testing2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue,),
          // ElevatedButton(onPressed: () async{
          //   var total = await complexTask();
          //   debugPrint('Result 1: $total');
          // }, child: const Text('Task 1')),
          ElevatedButton(
            onPressed: ()async{
              final receiverPort = ReceivePort();
            
              await Isolate.spawn(complexTask, receiverPort.sendPort);
              receiverPort.listen((total){
                debugPrint('Result 2: $total');
              });
            },
            child: const Text('Task 2'),
          )
        ],
      ),
    );
  }
}

complexTask(SendPort sendPort){
  var total = 0;
  for(var i =0; i<1000000000; i++){
    total+=i;
  }
  sendPort.send(total);
}