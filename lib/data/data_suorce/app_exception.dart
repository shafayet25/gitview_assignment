
class AppException implements Exception{
  final message;
  final Prefix;

  AppException([this.message,this.Prefix]);
}
class InternetExcptions extends AppException{
    InternetExcptions([String? message]):super(message,'No Internet');
  }

class requestTimeOut extends AppException{
    requestTimeOut([String? message]):super(message,'Request Time Out');
  }

class serverTimeOut extends AppException{
    serverTimeOut([String? message]):super(message,'Internal Server Error');
  }