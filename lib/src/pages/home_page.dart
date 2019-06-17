import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';
import 'package:flutter_films/src/widgets/card_swiper_widget.dart';


class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards()
          ],
        ),
      )
    );
  }

  Widget _swiperCards() {

    final FilmsProvider filmsProvider = new FilmsProvider();

    filmsProvider.getNowPlaying();

    return CardSwiper( 
      films: [1,2,3,4,5],
     );




  }
}