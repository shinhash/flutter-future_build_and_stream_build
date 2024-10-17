import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FutureBuilder<int>(
      body: StreamBuilder<int>(
        // future: getNumberToFutureBuilder(),
        stream: getNumberToStreamBuilder(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          print('------- data -------');
          print(snapshot.connectionState);
          print(snapshot.data);
          print('--------------------');

          if (snapshot.connectionState == ConnectionState.active) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    snapshot.data.toString(),
                  ),
                ],
              ),
            );
          }

          /// error
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text('${error}'),
            );
          }

          /// data check
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Center(
              child: Text('${data}'),
            );
          }

          return Center(
            child: Text('데이터가 없습니다.'),
          );
        },
      ),
    );
  }

  Future<int> getNumberToFutureBuilder() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();
    // throw 'error test';
    return random.nextInt(100);
  }

  Stream<int> getNumberToStreamBuilder() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}
