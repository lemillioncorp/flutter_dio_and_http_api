import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_http/api/getRequest.dart';
import 'package:flutter_api_http/screens/DioScreen.dart';
import 'package:flutter_api_http/screens/HttpScreen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = "No Request API";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    "https://miro.medium.com/max/700/1*g57qFfw1l_l1j2Q3t2dPSw.jpeg",
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DioScreen(
                              title: "Dio Screen API",
                            )),
                  );
                },
                child: const Text(
                  "onPressed Me Dio",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DioScreen(
                              title: "Http Screen API",
                            )),
                  );
                },
                child: const Text(
                  "onPressed Me Http",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  httpRequestData() async {
    try {
      var dio = Dio();

      var response = await dio.get(
          "https://images.pexels.com/videos/2499611/free-video-2499611.jpg?fit=crop&w=1200&h=630&auto=compress&cs=tinysrgb");

      _response = response.data.toString();
      print("----------------------------------");
      print(response.statusCode);
      print("----------------------------------");
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }
}
