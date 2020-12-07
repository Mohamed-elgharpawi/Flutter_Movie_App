import 'package:lab3/data_access_layer/model/movie.dart';
import 'package:lab3/data_access_layer/model/movie_details.dart';
import 'package:lab3/data_access_layer/network_client.dart';

class MovieApi{

  Future<List<Result>> fetchMovies() async {

   /* HttpClient client= new HttpClient();
    client.get('https://data_access_layer.api.themoviedb.org/3/movie/popular?api_key=b1b4dff13bd7f4d3012c38dab715678c&page=1');
*/


    var jsonResponse= await HttpClient().get('https://api.themoviedb.org/3/movie/popular?api_key=b1b4dff13bd7f4d3012c38dab715678c&page=3');


    final movie = movieFromJson(jsonResponse.body);

    List<Result> moviesResult= movie.results;
    //print(moviesResult[4].title +"here");
    return movie.results;



  }


  Future<List<Genre>> fetchMovieGenre(movieId) async{
    var jsonResponse= await HttpClient().get('https://api.themoviedb.org/3/movie/'+movieId+'?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US');

    final movieDetails = movieDetailsFromJson(jsonResponse.body);


    List<Genre> movieGenres=movieDetails.genres;

    print(movieGenres[0].name +"hereg");
    return movieDetails.genres;






  }




  Future<MovieDetails> fetchMovieDetails(movieId) async{
    var jsonResponse= await HttpClient().get('https://api.themoviedb.org/3/movie/'+movieId+'?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US');

    final movieDetails = movieDetailsFromJson(jsonResponse.body);


    List<Genre> movieGenres=movieDetails.genres;

    print(movieGenres[0].name +"hereg");
    return movieDetails;






  }




}