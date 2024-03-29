import 'dart:async';
import 'dart:convert';

import 'package:flutter_films/src/models/actors_model.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:http/http.dart' as http;

class FilmsProvider {

  String _apiKey = '56800e810d6885d4376aa1f73b7c2a6b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


  //Para el stream
  int _popularPage = 0;
  bool _loading = false;

  List<Film> _popularList = new List();
  final _popularStreamController = StreamController<List<Film>>.broadcast(); //esto lo van a escuchar muchos


  Function (List<Film>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Film>> get popularStream => _popularStreamController.stream;

  void disposeStreams () {
    _popularStreamController?.close(); //el signo de pregunta es por si no está inicializado

  }

  Future <List<Film>> _proccessResponse (Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final filmsList = new Films.fromJsonList(decodedData['results']);
    return filmsList.items;
  }

  Future <List<Film>>getNowPlaying () async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key':_apiKey,
      'language':_language
    });

    return await _proccessResponse(url);

  }

  Future <List<Film>>getPopular () async {

    if ( _loading ) return []; //flag para no llamar el servicio muchas veces

    _loading = true;

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key':_apiKey,
      'language':_language,
      'page':_popularPage.toString()
    });

    final response = await _proccessResponse(url);

    _popularList.addAll(response);

    popularSink(_popularList);
    _loading = false;
    return response;
  }

  Future <List<Actor>>getCast ( String filmId ) async {

    final url = Uri.https(_url, '3/movie/$filmId/credits', {
      'api_key':_apiKey
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final actorsList = new Cast.fromJsonList(decodedData['cast']);
    return actorsList.actors;

  }

  Future <List<Film>>searchFilm ( String film ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key':_apiKey,
      'language':_language,
      'query': film,
      'page': '1'
    });

    return await _proccessResponse(url);

  }



}