import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);

  final List<Film> films;

  CardSwiper ({ @required this.films});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){

            films[index].uniqueId = '${films[index].id}-tarjetas';

            return Hero(
              tag: films[index].uniqueId ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _createGesture(context, films[index])
                //Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover)
              ),
            );
            
          },
          itemCount: films.length,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
      ),
    );
  }

  Widget _createGesture ( BuildContext context, Film film) {

    final widgetImage = FadeInImage(
      image: NetworkImage( film.getPosterImg() ),
      placeholder: AssetImage('assets/img/no-image.jpg'),
      fit: BoxFit.cover,
    );


    return GestureDetector(
      child: widgetImage,
      onTap: (){
        //print ('titulo de la pelicula ${film.title}');
        Navigator.pushNamed(context, 'detalle', arguments: film);
      },
    );



  }


}