part of 'services.dart';

// Request type
enum RequestType { post, get }

class HttpService {
  final Client _instance;

  HttpService() : _instance = Client();

  Future<Result> request({
    required RequestType? requestType,
    required String url,
    dynamic parameter,
    Map<String, String>? headers,
  }) async {
    try {
      switch (requestType) {

        // Send a POST request with the given parameter.
        case RequestType.post:
          final Response response = await _instance.post(Uri.parse(url),
              body: parameter, headers: headers);

          if (response.statusCode == 200) {
            return Result.success(jsonDecode(response.body));
          } else {
            return Result.error(_exception);
          }

        // Send a GET request with the given parameter.
        case RequestType.get:
          final Response response =
              await _instance.get(Uri.parse(url), headers: headers);

          if (response.statusCode == 200) {
            return Result.success(jsonDecode(response.body));
          } else {
            return Result.error(_exception);
          }

        default:
          throw RequestTypeNotFoundException(_requestTypeNotFoundException);
      }
    } on SocketException {
      return Result.error(_socketException);
    } on FormatException {
      return Result.error(_formatException);
    } on HttpException {
      return Result.error(_httpException);
    } catch (e) {
      return Result.error(_exception);
    }
  }

  // Exception messages
  final String _exception =
      'Something went wrong! Please try again in a moment!';

  final String _socketException =
      'Unable to reach the internet! Please try again in a moment.';

  final String _formatException = 'Invalid Request';

  final String _httpException =
      'Invalid data received from the server! Please try again in a moment.';

  final String _requestTypeNotFoundException =
      'The HTTP request mentioned is not found';
}

// Request type not found exception
class RequestTypeNotFoundException implements Exception {
  String cause;
  RequestTypeNotFoundException(this.cause);
}

// Convert response in result [Success] and [Error]
class Result<T> {
  Result._();

  factory Result.success(T value) = Success<T>;

  factory Result.error(T message) = Error<T>;
}

class Error<T> extends Result<T> {
  Error(this.message) : super._();
  final T message;
}

class Success<T> extends Result<T> {
  Success(this.value) : super._();
  final T value;
}
