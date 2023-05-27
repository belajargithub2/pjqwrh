import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConsumeApiScreen extends StatefulWidget {
  const ConsumeApiScreen({Key? key}) : super(key: key);

  @override
  State<ConsumeApiScreen> createState() => _ConsumeApiScreenState();
}

class _ConsumeApiScreenState extends State<ConsumeApiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  List<dynamic>? data;

  Future<String> fetchData() async {
    var response = await http.get(Uri.parse(apiUrl));

    setState(() {
      data = jsonDecode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Example"),
      ),
      body: ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data![index]['title']),
            subtitle: Text(data![index]['body']),
          );
        },
      ),
    );
  }
}
