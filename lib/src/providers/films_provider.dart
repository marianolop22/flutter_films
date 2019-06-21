import 'dart:async';
import 'dart:convert';

import 'package:flutter_films/src/models/film_model.dart';
import 'package:http/http.dart' as http;

class FilmsProvider {

  String _apiKey = '56800e810d6885d4376aa1f73b7c2a6b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


  //Para el stream
  int _popularPage = 0;
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

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key':_apiKey,
      'language':_language,
      'page':_popularPage.toString()
    });

    final response = await _proccessResponse(url);

    _popularList.addAll(response);

    popularSink(_popularList);

    return response;
  }




}