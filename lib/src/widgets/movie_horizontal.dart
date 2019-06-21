import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);

  final List<Film> films;
  final Function nextPage;

  MovieHorizontal ( { @required this.films, @required this.nextPage } );

    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3,      
    );


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.20,
      child: PageView.builder( //este builder genera las imágenes bajo demanda
        pageSnapping: false,
        controller: _pageController,
        itemCount: films.length,
        itemBuilder: (BuildContext context, int i) {
          return _card ( context, films[i]);
        },
        //children: _cards(context)
      ),
    );
  }

  Widget _card ( BuildContext context, Film film ) {

    final cardFilm = Container (
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( film.getPosterImg() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 100.0,//150 original
            ),
          ),
          SizedBox(height: 5.0),
          Text (
            film.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector (
      child: cardFilm,
      onTap: (){
        //print ('titulo de la pelicula ${film.title}');
        Navigator.pushNamed(context, 'detalle', arguments: film);
      },
    );

  }


  List<Widget> _cards (context) {

    return films.map ( (film) {
      return Container (
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( film.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 100.0,//150 original
              ),
            ),
            SizedBox(height: 5.0),
            Text (
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),

      );
    }).toList();
  }


}