import 'package:ankit_chawla/Providers/GoogleSignInProvider.dart';
import 'package:ankit_chawla/Screens/MovieEditForm.dart';
import 'package:ankit_chawla/Widgets/StandardAppBar.dart';
import 'package:flutter/material.dart';
import 'package:ankit_chawla/Screens/MovieForm.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ankit_chawla/MovieModel.dart';
import 'package:ankit_chawla/Database.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:ankit_chawla/Widgets/LogoutDialog.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standardAppBar("Movies", context, Colors.red,
            Icons.movie_creation_rounded, () {}, [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                logoutDialog(context, provider);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
                size: 25,
              ))
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MovieForm()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
          child: ValueListenableBuilder<Box<Movie>>(
              valueListenable: Boxes.getMovies().listenable(),
              builder: (context, box, _) {
                final movies = box.values.toList().cast<Movie>();
                return showMovies(movies);
              }),
        ));
  }
}

Widget showMovies(List<Movie> movies) {
  if (movies.isEmpty) {
    return Center(
      child: Text(
        'No Movies yet!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'ProximaNova',
        ),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = movies[index];

              return showCard(context, transaction);
            },
          ),
        ),
      ],
    );
  }
}

Widget showCard(BuildContext context, Movie movie) {
  Uint8List picture;
  bool isPic = false;
  if (movie.picSt != null) {
    picture = new Uint8List.fromList(movie.picSt.codeUnits);
    isPic = true;
  }
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: Container(
        width: 70,
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: movie.picSt != null
              ? Image.memory(
                  picture,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/reel.jpg",
                  fit: BoxFit.cover,
                ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieEditForm(
                      movie, movie.name, movie.director, movie.picSt, isPic)));
            },
            icon: Icon(
              Icons.edit_rounded,
            ),
            color: Colors.red,
          ),
          IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () {
              deleteMovie(movie);
            },
            icon: Icon(Icons.delete_rounded),
            color: Colors.red,
          ),
        ],
      ),
      title: Text(
        movie.name,
        maxLines: 2,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        movie.director,
        maxLines: 2,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
  );
}
