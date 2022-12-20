import 'package:meta/meta.dart';

@immutable
class Tour {
  final String assetImage;
  final String name;

  const Tour({required this.assetImage, required this.name});
}

List<Tour> getTours() {
  return [
    const Tour(name: 'England', assetImage: 'assets/images/london.jpg'),
    const Tour(name: 'France', assetImage: 'assets/images/paris.jpg'),
    const Tour(name: 'Ukraine', assetImage: 'assets/images/kyiv.jpg'),
    const Tour(name: 'Portugal', assetImage: 'assets/images/lissabon.jpg'),
    const Tour(name: 'Australia', assetImage: 'assets/images/sydney.jpg'),
    const Tour(name: 'USA', assetImage: 'assets/images/newyork.png'),
  ];
}
