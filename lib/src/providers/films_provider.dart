import 'dart:convert';

import 'package:flutter_films/src/models/film_model.dart';
import 'package:http/http.dart' as http;

class FilmsProvider {

  String _apiKey = '56800e810d6885d4376aa1f73b7c2a6b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


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

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key':_apiKey,
      'language':_language
    });

    return await _proccessResponse(url);
  }




}