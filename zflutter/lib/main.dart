import 'package:flutter/material.dart';

import 'examples/examples.dart';
import 'examples/getting_started.dart';
import 'flutter_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.grey[200],
          appBarTheme: const AppBarTheme(elevation: 0),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          ...[...Examples.list, ...BasicSamples.list, ...GettingStartedSamples.list].asMap().map(
                (key, example) => MapEntry(
                  example.route,
                  (context) => Scaffold(
                    backgroundColor: example.backgroundColor,
                    appBar: example.route == '/logo'
                        ? null
                        : AppBar(
                            centerTitle: true,
                            title: Text(example.title),
                          ),
                    body: MadeWithFlutterContainer(
                      logoStyle: example.logoStyle ?? FlutterLogoColor.original,
                      child: example.builder(context),
                    ),
                  ),
                ),
              ),
        },
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zflutter'),
      ),
      body: GridView.builder(
        itemBuilder: (context, index) {
          final item = examples[index];
          return KeyedSubtree(
            key: Key(item.title),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(item.route);
              },
              child: Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.longestSide,
                      width: MediaQuery.of(context).size.longestSide,
                      child: TickerMode(
                        enabled: false,
                        child: item.builder(context),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey[100]?.withOpacity(0.8),
                    child: Center(
                        child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  )
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
          childAspectRatio: 1,
        ),
        itemCount: examples.length,
      ),
    );
  }

  List<Example> get examples => [...Examples.list, ...BasicSamples.list, ...GettingStartedSamples.list];
}
