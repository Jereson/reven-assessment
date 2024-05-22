class GenericResponse {
  bool? success;
  String? message;

  GenericResponse({this.success, this.message});

  GenericResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) success = json["success"];
    if (json["message"] is String) message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data["success"] = success;
    data["message"] = message;
    return data;
  }
}