// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class TokenModel {
  String? jwt;
  String? refreshToken;

  TokenModel({this.jwt, this.refreshToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
