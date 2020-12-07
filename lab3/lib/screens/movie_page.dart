
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab3/data_access_layer/model/movie.dart';
import 'package:lab3/providers/Movies.dart';
import 'package:lab3/providers/MoviesDetails.dart';
import 'package:lab3/providers/MoviesGenres.dart';
import 'package:provider/provider.dart';

import 'details_screen.dart';

class MoviePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Movies Page'),),
      body: ChangeNotifierProvider<Movies>(
        create:(context) => Movies() ,
        child: MoviesPageBody(),
        
       // child: GenresList('419704'),

      ),

    );
  }
}


class MoviesPageBody extends StatefulWidget{
  @override
  _MoviesPageBodyState createState() => _MoviesPageBodyState();
}

class _MoviesPageBodyState extends State<MoviesPageBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Movies>(context,listen:false ).fetchMovies();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


          return Consumer<Movies>(



            builder:
                (BuildContext context,Movies movies, Widget child){




if(movies.moviesList.length>0){

  return ListView.builder(





    itemCount: movies.moviesList.length,
    itemBuilder:(_,i)=>Container(
        height: 200.0,
        child: GestureDetector(



          child: Card(
            child: Container(child: ListRow(movies.moviesList[i])),


          ),

          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailScreen(result:
              movies.moviesList[i],);
            }));
          },







        )

    ),



   );}

else{

  return Center(child: CircularProgressIndicator(),);}
          });
  }

      }
//
//    return Consumer<Movies>(
//
//
//
//    builder:
//          (BuildContext context,Movies movies, Widget child)=>ListView.builder(
//
//
//            itemCount: movies.moviesList.length,
//     itemBuilder:(_,i)=>Container(
//          height: 200.0,
//       child: Card(
//         child: Row(
//
//           children: <Widget>[
//
//             Container(
//               width: 120.0,
//               height: 160.0,
//               child: Image( image: NetworkImage('https://image.tmdb.org/t/p/w500/'+movies.moviesList[i].posterPath),),
//
//             )
//
//
//
//
//
//           ],
//
//
//         ),
//
//
//       )
//
//
//
//
//
//     )
//
//    ),
//
//
//
//    ) ;





class ListRow extends StatelessWidget {
  final Result _movie;

 ListRow(this._movie);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: <Widget>[

        Container(
          width: 120.0,
          height: 160.0,
      child: Hero(
        tag: 'imageHero'+_movie.id.toString().trim(),
          child: Image( image: NetworkImage('https://image.tmdb.org/t/p/w500/'+_movie.posterPath),),
      )
        )
        ,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[

              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(_movie.title ,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),

              Text('Release on:'+_movie.releaseDate.year.toString()+'-'+_movie.releaseDate.month.toString()+'-'+_movie.releaseDate.day.toString() ,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),

              SizedBox(
                height: 5.0,
              ),




                  ChangeNotifierProvider<MoviesDetails>(
                    create:(context) {

                      if(_movie.id.toString()!=null){
                       return MoviesDetails(_movie.id.toString());
                      }
                      else{
                        return null ;
                      }

                    },


                    child: Expanded(


                        child: GenresList()),)


            ,



               Text(_movie.overview.toString() ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                 overflow: TextOverflow.ellipsis,
                 maxLines: 3,
                 softWrap: true,
                ),
              SizedBox(
                height: 10.0,
              )






            ],



          ),
        )





      ],


    );
  }
}


///////////////////////////////////////////////
class GenresList extends StatelessWidget{



  @override
  Widget build(BuildContext context) {


    // TODO: implement build
     return Consumer<MoviesDetails>(




    builder:
          (BuildContext context,MoviesDetails movieDetails, Widget child){
      if(movieDetails.movieDetails.id!=null) {


       return ListView.builder(
          scrollDirection: Axis.horizontal,

          shrinkWrap: true,

          itemCount: movieDetails.movieDetails.genres.length,
          itemBuilder:(_,i)=>


              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Text(


                  movieDetails.movieDetails.genres[i].name.toString(),
                  style: TextStyle(
                      fontWeight:  FontWeight.bold,
                      color: Colors.red


                  ),


                ),
              ),
        );


          }
      return Container(child: Text("Loading genres..."),);
          }


            );








        }
}
