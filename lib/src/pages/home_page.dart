import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';
import 'package:flutter_films/src/search/search_delegate.dart';
import 'package:flutter_films/src/widgets/card_swiper_widget.dart';
import 'package:flutter_films/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  final FilmsProvider filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {

    filmsProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());



            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if ( snapshot.hasData ) {
          return CardSwiper( films: snapshot.data );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );

  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead )
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: filmsProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if ( snapshot.hasData ) {
                return MovieHorizontal( 
                  films: snapshot.data,
                  nextPage: filmsProvider.getPopular,
                );
              } else {
                return  Center(child: CircularProgressIndicator());
              }            },
          ),
        ],
      ),
    );

  }
}