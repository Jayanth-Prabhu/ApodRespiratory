import 'package:dio/dio.dart';

class Service {
  final String baseURL =
      "https://api.nasa.gov/planetary/apod?api_key=aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw&date=";
  Future getDetails(String date) async {
    final String dateapi = '$baseURL$date';
    var response = await Dio().get(dateapi);

    return response.data;
  }
}
