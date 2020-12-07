import 'package:flutter/cupertino.dart';
import 'package:lab3/data_access_layer/model/movie_details.dart';
import 'package:lab3/data_access_layer/repository/movie_repository.dart';

class MoviesGenres extends ChangeNotifier{

  List<Genre> genreList=<Genre>[];
//MoviesGenres(movieId){
//
//  //fetchGenres(movieId);
//}

  void fetchGenres(movieId) async{
    genreList = await MovieRepository().movieGenres(movieId);
    notifyListeners();


  }




}