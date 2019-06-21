import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {
  //const FilmDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( film ),
          SliverList (
            delegate: SliverChildListDelegate (
              [
                SizedBox(height: 10.0,),
                _posterTitle(context, film),
                _description (film),
                _description (film),
                _description (film),
              ]
            ),
          )
        ],
      )
    );
  }


  Widget _createAppBar ( Film film ) {

    return SliverAppBar(

      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar (
        centerTitle: true,
        title: Text(
          film.title,
          style: TextStyle (
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(film.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _posterTitle ( BuildContext context, Film film ) {

    return Container (
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row (
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image (
              image: NetworkImage ( film.getPosterImg() ),
              height: 150.0,
            ),
          ),
          SizedBox (width: 20.0,),
          Flexible (
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( film.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, ),
                Text( film.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis, ),
                Row (
                  children: <Widget>[
                    Icon ( Icons.star_border, color: Colors.black ),
                    Text ( film.voteAverage.toString(), style: Theme.of(context).textTheme.subhead ,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _description (Film film) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        film.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

}