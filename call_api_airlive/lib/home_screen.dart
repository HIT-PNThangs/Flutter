import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> listUsers;

  @override
  void initState() {
    super.initState();
    listUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    try {
      Response response = await Dio().get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
        return listUsers;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<User>>(
          future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List<User>)[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 5),
                          Text(user.email),
                          const SizedBox(height: 5),
                          Text("${user.address.street} ${user.address.suite} ${user.address.city} ${user.address.zipcode}"),
                          const SizedBox(height: 5),
                          Text(user.phone),
                          const SizedBox(height: 5),
                          Text(user.website),
                          const SizedBox(height: 5),
                          Text(user.company.name),
                          const SizedBox(height: 5),
                          Text(user.company.catchPhrase),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: (snapshot.data as List<User>).length);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
              ),
            );
          },
        ));
  }
}