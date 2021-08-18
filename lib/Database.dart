import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'MovieModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Boxes {
  static Box<Movie> getMovies() => Hive.box<Movie>('movies');
}

void addMovie(String name, String director, String pic) {
  final movie = Movie()
    ..name = name
    ..director = director
    ..picSt = pic;

  final box = Boxes.getMovies();

  box.add(movie);

  showToast("Added Movie", ToastGravity.CENTER);
}

void editMovie(Movie movie, String name, String director, String picSt) {
  movie.name = name;
  movie.director = director;
  movie.picSt = picSt;

  movie.save();

  showToast("Movie Edited", ToastGravity.CENTER);
}

void deleteMovie(Movie movie) {
  movie.delete();

  showToast("Deleted Movie", ToastGravity.BOTTOM);
}

void showToast(String message, ToastGravity gravity) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
