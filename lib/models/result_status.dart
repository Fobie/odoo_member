class ResultStatus {
  bool status = true;
  String message = '';
  dynamic data;

  ResultStatus({this.status = true, this.message = "", this.data});

  factory ResultStatus.formJson(Map<String, dynamic> json) {
    return ResultStatus(
        data: json['data'], message: json['message'], status: json['status']);
  }
}
