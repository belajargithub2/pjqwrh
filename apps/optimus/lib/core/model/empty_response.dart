class EmptyResponse {
  String? message;

  EmptyResponse({this.message});

  EmptyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}
