
import 'package:flutter/material.dart';
import 'package:lab3/data_access_layer/model/movie.dart';
import 'package:lab3/data_access_layer/model/movie_details.dart';
import 'package:lab3/providers/MoviesDetails.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Result result;

  const DetailScreen({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(title: Text(result.title),),
        body:
        ChangeNotifierProvider<MoviesDetails>(
          create:(context) => MoviesDetails(result.id.toString()) ,
          child:
          DetailsScroll(),
        ));
  }
}

class DetailsScroll extends StatelessWidget {

//  final Result result;
//  DetailsScroll({this.result});

  @override
  Widget build(BuildContext context) {



    return
      Consumer<MoviesDetails>(




          builder:
              (BuildContext context,MoviesDetails movie, Widget child){

            if(movie.movieDetails.id!=null){

              return  SingleChildScrollView(

                child: Column(
                  children: <Widget>[
                    Container(
                      height: 550.0,
                        margin: EdgeInsets.only(top: 0,left: 5.0,right: 5.0),
//                padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular( 20.0),topRight:Radius.circular(20.0))


                        ),
                        child: GestureDetector(
                          child: Hero(



                            tag: 'imageHero'+movie.movieDetails.id.toString(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),


                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/'+movie.movieDetails.posterPath,
                                fit: BoxFit.fill,


                              ),
                            ),
                          ),

                          onTap: (){

                            Navigator.pop(context);
                          },
                        )


                    ),

                    MoreDetailsScreen(data: movie.movieDetails),


                  ],
                ),


              );


            }
            else{

              return Center(child: CircularProgressIndicator(),);}




          }





      );


  }
}

class MoreDetailsScreen extends StatelessWidget {
  final MovieDetails data;
  MoreDetailsScreen({this.data});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(data.title,
                  style: TextStyle(
                      fontSize: 30.0,
                    fontWeight: FontWeight.bold

                  ),
                ),
              ),

              Text(data.voteAverage.toString(),
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold


                ),










              )


            ],

          ),
          SizedBox(
            height: 10,
          ),




Container(
  height: 30.0,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,

    shrinkWrap: true,

    itemCount: data.genres.length,

    itemBuilder:(_,i)=>


        Container(
          margin: EdgeInsets.only(right: 2.0),
          child: Text(


            data.genres[i].name.toString()+',',
            style: TextStyle(
                fontWeight:  FontWeight.w400,
                color: Colors.white
                ,
              fontSize: 20,


            ),


          ),
        ),
  ),



),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(

               'Adult: '+data.adult.toString() +' \nminuties :'+data.runtime.toString(),
                style: TextStyle(
                  fontWeight:  FontWeight.w400,
                  color: Colors.white
                  ,
                  fontSize: 20,


                ),



              ),


           AnimatedIcon(),

            ],
          ),


          Container(
            margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
            child:Text(

              'Description:',
              style: TextStyle(
                fontWeight:  FontWeight.bold,
                color: Colors.black
                ,
                fontSize: 30,


              ),



            ) ,
            


          ),


          Text(

            data.overview,
            style: TextStyle(
              fontWeight:  FontWeight.normal,
              color: Colors.white
              ,
              fontSize: 20,


            ),



          ) ,







        ],





      ),
    );
  }


}

class AnimatedIcon extends StatefulWidget {


  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon> with TickerProviderStateMixin{

  AnimationController _breathingController;
  var _breathe = 0.0;
  AnimationController _angleController;
  var _angle = 0.0;
  var _color=Colors.white;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
       // _breathingController.forward();
      }
    });
    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
    _breathingController.forward();

    _angleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _angleController.addListener(() {
      setState(() {

        _angle = _angleController.value * 360 / 360 * 2 * 3.14;

      });
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _angleController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = 40.0 - 20.0 * _breathe;
    return Container(
          child: GestureDetector(
            onTap: _buttonTap,
            child: Container(
              width: size,
              height: size,
              child: Transform.rotate(
                angle: 720 / 360 * 3.14 ,
                child: Material(
                  borderRadius: BorderRadius.circular(size / 3),
                  color: Colors.pinkAccent,
                  child: Transform.rotate(
                    angle: _angle,
                    child: Icon(
                      Icons.favorite,
                      size: size,
                      color: _color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
  void _buttonTap() {

    setState(() {
      if(_color==Colors.white){
        _color=Colors.amber;
      }else{_color=Colors.white;}
    });


    if (_angleController.status == AnimationStatus.completed) {
      _angleController.reverse();


    } else if (_angleController.status == AnimationStatus.dismissed) {
      _angleController.forward();
    }
  }
}
