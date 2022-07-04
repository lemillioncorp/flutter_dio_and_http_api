import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioScreen extends StatefulWidget {
  const DioScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DioScreen> createState() => _DioScreenState();
}

class _DioScreenState extends State<DioScreen> {
  String _response = "No Request API";
  TextEditingController _id = TextEditingController();

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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _response,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      width: 180,
                      child: TextField(
                        controller: _id,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Insert Id To Search',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        dioRequestDataByID();
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  dioRequestData();
                },
                child: Text(
                  "Request Data",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  dioPostData();
                },
                child: Text(
                  "Post Data",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  dioRequestData() async {
    try {
      var dio = Dio();

      var response =
          await dio.get("https://jsonplaceholder.typicode.com/users/1");

      _response = response.data.toString();

      setState(() {
        _response = response.data.toString();
      });

      showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Get Result'),
            content: Text(_response.trim()),
          );
        },
      );

      print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }

  dioRequestDataByID() async {
    try {
      var dio = Dio();

      var code = _id.text;

      print(code);
      if (code.isEmpty) {
        setState(() {
          _response =
              "Please Selected on id. Views Lis in: https://jsonplaceholder.typicode.com/users/";
        });

        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text(
                  "Please Selected on id. Views Lis in: https://jsonplaceholder.typicode.com/users/"),
            );
          },
        );
        return false;
      }
      var response =
          await dio.get("https://jsonplaceholder.typicode.com/users/$code");

      _response = response.data.toString();
      setState(() {
        _response = response.data.toString();
      });
      showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Get Result'),
            content: SingleChildScrollView(child: Text(_response)),
          );
        },
      );

      // print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
      showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User not Exist'),
          );
        },
      );

      setState(() {
        _response = "Error Ocorred: $errorGet";
      });
    } finally {
      //Recontruir BUild
    }
  }

  dioPostData() async {
    try {
      var dio = Dio();
      var response =
          await dio.post("https://jsonplaceholder.typicode.com/users/", data: {
        "name": "António Kozan",
        "username": "lemillioncorp",
        "email": "akuchihastain1@gmail.com"
      });

      _response = response.data.toString();

      setState(() {
        _response = response.data.toString();
      });

      showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Post Result'),
            content: Text(_response),
          );
        },
      );
      print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }
}
