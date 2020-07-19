class BaseResponse {

  String responseStatus;

  String message;

  BaseResponse({this.responseStatus,this.message});


  BaseResponse.fromJson(Map<String, dynamic> json) {

    responseStatus = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.responseStatus;
    data['message'] = this.message;
    return data;
  }
}