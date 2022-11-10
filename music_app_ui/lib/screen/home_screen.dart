import 'package:flutter/material.dart';
import 'package:music_app_ui/models/play_list_model.dart';
import 'package:music_app_ui/models/song_models.dart';
import 'package:music_app_ui/widget/playlist_card.dart';
import 'package:music_app_ui/widget/section_header.dart';
import 'package:music_app_ui/widget/song_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    List<Playlist> playLists = Playlist.playlists;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const DiscoverMusic(),
              const Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20, bottom: 10),
                child: SectionHeader(title: "Trending Music"),
              ),
              TrendingMusic(listSong: songs),
              const Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20, top: 20),
                child: SectionHeader(title: "Play list"),
              ),
              PlaylistMusic(playlists: playLists),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaylistMusic extends StatelessWidget {
  const PlaylistMusic({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: playlists.length,
            itemBuilder: ((context, index) {
              return PlaylistCard(playlist: playlists[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class TrendingMusic extends StatelessWidget {
  final List<Song> listSong;

  const TrendingMusic({Key? key, required this.listSong}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.27,
          child: ListView.builder(
              itemCount: listSong.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SongCard(song: listSong[index]);
              }),
        ));
  }
}

class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            "Enjoy your favorite music",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                hintText: "Search",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade400),
                prefixIcon:
                    Icon(Icons.search_outlined, color: Colors.grey.shade400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none)),
          )
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple.shade800,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: "Favorites"),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline), label: "Play"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_outlined),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1659025435463-a039676b45a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
