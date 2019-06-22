import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_films/src/providers/films_provider.dart';

class DataSearch extends SearchDelegate{

  String selection = '';

  // final films = [
  //   'Batman',
  //   'Superman'
  // ];
  // final recentFilms = [
  //   'Spiderman',
  //   'Capitan America'
  // ];

  final filmsProvider = new FilmsProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon (Icons.clear),
        onPressed: (){
          query = '';
        },

      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon (
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.indigoAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) return Container();


    return FutureBuilder(
      future: filmsProvider.searchFilm(query),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        
        if (snapshot.hasData) {

          final films = snapshot.data;

          return ListView(
            children: films.map( (film) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(film.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(film.title),
                subtitle: Text (film.originalTitle),
                onTap: () {
                  close(context, null);
                  film.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: film);
                },
              );
            }).toList(),
          );
        } else {
          return Center (
            child: CircularProgressIndicator()
          );
        }
      },
    );


    // Sugerencias
    // final suggestedList = (query.isEmpty) 
    //             ? recentFilms 
    //             : films.where( (p) => p.toLowerCase().startsWith( query.toLowerCase() ) ).toList();

    // return ListView.builder(
    //   itemCount: suggestedList.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon (Icons.movie),
    //       title: Text(suggestedList[i]),
    //       onTap: (){
    //         selection = suggestedList[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }
}