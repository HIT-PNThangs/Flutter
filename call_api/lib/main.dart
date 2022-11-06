import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getUserData() async {
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));

    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for(var u in jsonData) {
      User user = User(u['name'], u['email'], u['username']);

      users.add(user);
    }

    print(users[0].userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Data"),
      ),
      body: Card(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if(snapshot.data == null) {
              return const Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].userName),
                    trailing: Text(snapshot.data[index].email),
                  );
                }
              );
            }
          },
        ),
      )
    );
  }
}

class User{
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
