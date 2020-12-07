import 'package:flutter/foundation.dart';
import 'package:lab3/data_access_layer/model/movie_details.dart';
import 'package:lab3/data_access_layer/repository/movie_repository.dart';

class MoviesDetails extends ChangeNotifier{

  MovieDetails movieDetails=new MovieDetails();
  MoviesDetails(movieId){

  fetchDetails(movieId);
}

  void fetchDetails(movieId) async{
    movieDetails = await MovieRepository().movieDetails(movieId);

    notifyListeners();


  }




}