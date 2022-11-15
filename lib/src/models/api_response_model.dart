import 'dart:convert';

class ApiResponse<T> {
  ApiResponse({
    this.results,
  });

  T? results;

  //FOR GETTING LIST OF MAPS
  factory ApiResponse.fromListJson(
          Map<String, dynamic> json, Function(List<dynamic>) create) =>
      ApiResponse<T>(
        results: json["results"] == null ? null : create(json["results"]),
      );
}
