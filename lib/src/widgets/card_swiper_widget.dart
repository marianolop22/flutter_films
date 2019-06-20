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
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( films[index].getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              )
              //Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover)
            );
            
          },
          itemCount: films.length,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
      ),
    );
  }
}