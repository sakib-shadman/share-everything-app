class LoginResponse {

  String id;

  String token;

  String email;

  String fullName;

  String responseStatus;

  String message;

  LoginResponse({this.id, this.token, this.email, this.fullName,this.responseStatus,this.message});


  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    token = json["token"];
    email= json["email"];
    fullName = json["fullName"];
    responseStatus = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.responseStatus;
    data['message'] = this.message;
    data['id'] = this.id;
    data['token'] = this.token;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    return data;
  }




}
