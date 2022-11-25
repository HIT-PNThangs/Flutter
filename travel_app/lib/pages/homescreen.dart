import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import './../styles/theme.dart' as style;
import '../blocs/bottom_bloc.dart';
import 'explore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BottomNavBarBloc _bottomNavBarBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.Colors.background,
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(EvaIcons.menu2Outline),
            color: Colors.black,
            onPressed: () {},
          ),
          title: Text(
            "Travel App",
            style: TextStyle(
                fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                EvaIcons.searchOutline,
              ),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.MYTRIPS:
              return _myTrips();

            case NavBarItem.FAVOURITE:
              return _favourite();

            case NavBarItem.PROFILE:
              return _profile();

            default:
              return const Explore();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            elevation: 10.0,
            unselectedFontSize: 10,
            selectedFontSize: 10,
            fixedColor: style.Colors.mainColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: snapshot.data!.index,
            onTap: _bottomNavBarBloc.pickItem,
            items: const [
              BottomNavigationBarItem(
                label: "Explore",
                icon: Icon(EvaIcons.compassOutline),
                activeIcon: Icon(EvaIcons.compass),
              ),
              BottomNavigationBarItem(
                label: 'My Trips',
                icon: Icon(EvaIcons.calendarOutline),
                activeIcon: Icon(EvaIcons.calendar),
              ),
              BottomNavigationBarItem(
                label: 'Favourite',
                icon: Icon(EvaIcons.bookmarkOutline),
                activeIcon: Icon(EvaIcons.bookmark),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(EvaIcons.clipboardOutline),
                activeIcon: Icon(EvaIcons.clipboard),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _myTrips() {
    return const Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _favourite() {
    return const Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _profile() {
    return const Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
