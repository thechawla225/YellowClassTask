import 'dart:typed_data';
import 'package:ankit_chawla/Database.dart';
import 'package:flutter/material.dart';
import 'package:ankit_chawla/Widgets/StandardAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ankit_chawla/MovieModel.dart';

class MovieEditForm extends StatefulWidget {
  final Movie movie;
  final String name;
  final String director;
  final String picSt;
  final bool isPic;
  MovieEditForm(this.movie, this.name, this.director, this.picSt, this.isPic);
  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieEditForm> {
  final moviekey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  var _namecontroller = TextEditingController();
  var _dcontroller = TextEditingController();

  String pic;
  String name;
  String director;
  XFile image;
  bool isPicked = false;
  Uint8List picture;

  void _saveForm(String name, String director) {
    if (moviekey.currentState.validate()) {
      editMovie(widget.movie, name, director, pic);
      moviekey.currentState.save();
      _namecontroller.clear();
      _dcontroller.clear();
    }
  }

  @override
  void initState() {
    _namecontroller.text = widget.name;
    _dcontroller.text = widget.director;
    name = widget.name;
    director = widget.director;

    if (widget.movie.picSt != null) {
      pic = widget.picSt;
    }

    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _dcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie.picSt != null) {
      picture = new Uint8List.fromList(widget.movie.picSt.codeUnits);
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: standardAppBar(
          "Edit Movie", context, Colors.red, Icons.arrow_back_ios_sharp, () {
        Navigator.of(context).pop();
      }, [
        Icon(
          Icons.ac_unit,
          color: Colors.transparent,
        )
      ]),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Form(
                key: moviekey,
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                          height: size.height * 0.60,
                          width: size.width,
                          child: widget.isPic
                              ? Image.memory(
                                  picture,
                                  fit: BoxFit.cover,
                                )
                              : isPicked
                                  ? Image.file(File(image.path))
                                  : Image.asset(
                                      "assets/images/reel.jpg",
                                      fit: BoxFit.cover,
                                    )),
                      Positioned(
                        right: 10,
                        bottom: 20,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            iconSize: 25,
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              Uint8List temp =
                                  File(image.path).readAsBytesSync();
                              pic = new String.fromCharCodes(temp);
                              if (image != null) {
                                setState(() {
                                  isPicked = true;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      height: size.height * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namecontroller,
                            onChanged: (newValue) => name = newValue,
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter a name';

                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.movie_filter),
                              hintText: 'Name',
                              errorStyle: TextStyle(color: Colors.red),
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _dcontroller,
                            onChanged: (newValue) => director = newValue,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter the director name';

                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Director',
                              errorStyle: TextStyle(color: Colors.red),
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.085,
                    ),
                    GestureDetector(
                      onTap: () {
                        _saveForm(name, director);
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        child: Center(
                            child: Text("Edit Movie",
                                style: TextStyle(
                                  fontFamily: 'ProximaNova',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ))),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
