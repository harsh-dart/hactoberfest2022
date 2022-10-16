import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsApi {
  static const _key = '9e041027dee746bdabe00fea9f2f864c';
  static late Map<String, dynamic> _data;
  static fetchNewsTopHeadLines() async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=$_key');
      var response = await http.get(url);
      _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchSportsNews() async {
    try {
      var url =
          Uri.parse('https://newsapi.org/v2/everything?q=sports&apiKey=$_key');
      var response = await http.get(url);
      _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchBusinessNews() async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/everything?q=business&apiKey=$_key');
      var response = await http.get(url);
      _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchGamingNews() async {
    try {
      var url =
          Uri.parse('https://newsapi.org/v2/everything?q=gaming&apiKey=$_key');
      var response = await http.get(url);
      _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchPoliticalNews() async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/everything?q=political%20india&apiKey=$_key');
      var response = await http.get(url);
      _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchProgrammingNews() async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/everything?q=coding%20programming&apiKey=$_key');
      var response = await http.get(url);
      final Map<String, dynamic> _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }

  static fetchScieneNews() async {
    try {
      var url =
          Uri.parse('https://newsapi.org/v2/everything?q=science&apiKey=$_key');
      var response = await http.get(url);
      final Map<String, dynamic> _data = json.decode(response.body);
      return _data;
    } catch (e) {
      print(e);
    }
  }
}
