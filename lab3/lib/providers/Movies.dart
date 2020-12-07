import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:lab3/data_access_layer/model/movie.dart';
import 'package:lab3/data_access_layer/repository/movie_repository.dart';

class Movies extends ChangeNotifier{
  List<Result> moviesList=<Result>[];
  Movies(){
   // fetchMovies();
  }

  void fetchMovies() async{
 moviesList =await MovieRepository().moviesResults();

notifyListeners();

}



}