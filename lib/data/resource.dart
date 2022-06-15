class Resource<T> {
  final T? data;

  Resource._(this.data);

  factory Resource.loading(T? data) => Loading(data);

  factory Resource.success(T? data) => Success(data);

  factory Resource.error({required String? errorMessage, T? data}) =>
      Error(errorMessage ?? "", data);
}

class Loading<T> extends Resource<T> {
  Loading(T? data) : super._(data);
}

class Success<T> extends Resource<T> {
  Success(T? data) : super._(data);
}

class Error<T> extends Resource<T> {
  final String? message;
  Error(this.message, T? data) : super._(data);
}
