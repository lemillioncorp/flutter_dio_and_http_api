import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpScreen extends StatefulWidget {
  const HttpScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HttpScreen> createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {
  String _response = "No Request API";
  TextEditingController id = TextEditingController();

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
            SizedBox(height: 15),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  httpRequestData();
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
                  httpPostData();
                },
                child: Text(
                  "Post Data",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                httpDeleteData();
              },
              child: Text(
                "Delete Data",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }

  httpRequestData() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));

      _response = response.body.toString();

      setState(() {
        _response = response.body.toString();
      });
      print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }

  httpPostData() async {
    try {
      var response = await http.post(
          Uri.parse("https://jsonplaceholder.typicode.com/users/"),
          body: {
            "name": "António Kozan",
            "username": "lemillioncorp",
            "email": "akuchihastain1@gmail.com"
          });

      _response = response.body.toString();

      setState(() {
        _response = response.body.toString();
      });
      print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }

  httpDeleteData() async {
    try {
      var response = await http
          .delete(Uri.parse("https://jsonplaceholder.typicode.com/users/$id"));

      _response = response.body.toString();
      print(response.statusCode);
    } catch (errorGet) {
      _response = "Error Ocorred: $errorGet";
    } finally {
      //Recontruir BUild
    }
  }
}
