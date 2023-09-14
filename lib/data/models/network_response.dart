class NetworkResponse{
  final int statusCode;
  final bool isSuccessfull;
  final Map<String,dynamic>? body;

  NetworkResponse(this.isSuccessfull,this.statusCode,  this.body);
}