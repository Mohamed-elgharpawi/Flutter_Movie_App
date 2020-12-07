import 'package:lab3/data_access_layer/api/movie_api.dart';
import 'package:lab3/data_access_layer/model/movie.dart';
import 'package:lab3/data_access_layer/model/movie_details.dart';

class MovieRepository{

Future<List<Result>> moviesResults() async=> await  MovieApi().fetchMovies();

Future<List<Genre>> movieGenres(movieId) async=>await MovieApi().fetchMovieGenre(movieId);

Future<MovieDetails> movieDetails(movieId) async=>await MovieApi().fetchMovieDetails(movieId);


}