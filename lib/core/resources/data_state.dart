

import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T ? data;
  final String ? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T remoteData) : super(data: remoteData);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(T? localData, errorMsg) : super(data: localData, error: errorMsg);
}