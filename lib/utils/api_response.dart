sealed class ApiResponse<T> {
  abstract String? message;
  abstract T? data;

  ApiResponse();

  factory ApiResponse.success(T data, {String? message}) => Success(data);

  factory ApiResponse.failure(String message, {T? data}) => Error(message);
}

class Success<T> extends ApiResponse<T> {
  @override
  String? message;

  @override
  T? data;

  Success(this.data);
}

class Error<T> extends ApiResponse<T> {
  @override
  String? message;

  @override
  T? data;

  Error(this.message);
}

class Loading<T> extends ApiResponse<T> {
  @override
  String? message;

  @override
  T? data;

  Loading();
}
