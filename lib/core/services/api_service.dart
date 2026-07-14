import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/api_response_model.dart';
import 'package:ava/core/models/file_entry_model.dart';
import 'package:dio/dio.dart';

typedef ApiException = DioException;

class ApiService {
  ApiService._(this._client);

  factory ApiService() => ApiService._(Dio(_options));

  factory ApiService.withToken(String token) => ApiService._(
        Dio(_options.copyWith()..headers['Authorization'] = 'Bearer $token'),
      );

  final Dio _client;
  static final _options = BaseOptions(
    baseUrl: AppStrings.apiBaseUrl,
  );

  @override
  String toString() {
    return """$ApiService(
      BaseUrl: ${_client.options.baseUrl},
      Authorization: ${_client.options.headers['Authorization']},
    )""";
  }

  ApiResponseModel _handleResponse(
    Response<Map<String, dynamic>> response,
  ) {
    if (response.statusCode == 200) {
      logger(response.data);
      return ApiResponseModel.fromJson(response.data!);
    } else {
      throw ApiException(
        requestOptions: response.requestOptions,
        response: response,
        message: response.statusMessage,
        stackTrace: StackTrace.current,
      );
    }
  }

  ApiResponseModel _handleException(DioException e, StackTrace t) {
    if (e.response?.data?.runtimeType == Map<String, dynamic>) {
      return ApiResponseModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
    }
    logger.e(e, stackTrace: t);
    throw ApiException(
      requestOptions: e.requestOptions,
      response: e.response,
      message: e.message,
      stackTrace: t,
    );
  }

  Future<ApiResponseModel> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return _handleResponse(response);
    } on DioException catch (e, t) {
      return _handleException(e, t);
    }
  }

  Future<ApiResponseModel> post(
    String path, {
    Object? data,
    Object? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    List<FileEntryModel>? files,
  }) async {
    try {
      final hasFiles = files != null && files.isNotEmpty;
      final form = formData != null || hasFiles
          ? FormData.fromMap(formData != null
              ? formData as Map<String, dynamic>
              : <String, dynamic>{})
          : null;
      if (form != null && hasFiles) {
        for (var entry in files) {
          var file = entry.file;
          if (file != null) {
            form.files.add(
              MapEntry(
                entry.field,
                await MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
          }
        }
      }

      final response = await _client.post<Map<String, dynamic>>(
        path,
        data: formData != null ? form : data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _handleResponse(response);
    } on DioException catch (e, t) {
      return _handleException(e, t);
    }
  }

  Future<ApiResponseModel> put(
    String path, {
    Object? data,
    Object? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    List<FileEntryModel>? files,
  }) async {
    try {
      final hasFiles = files != null && files.isNotEmpty;
      final form = formData != null || hasFiles
          ? FormData.fromMap(formData != null
              ? formData as Map<String, dynamic>
              : <String, dynamic>{})
          : null;
      if (form != null && hasFiles) {
        for (var entry in files) {
          var file = entry.file;
          if (file != null) {
            form.files.add(
              MapEntry(
                entry.field,
                await MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
          }
        }
      }

      final response = await _client.put<Map<String, dynamic>>(
        path,
        data: formData != null ? form : data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _handleResponse(response);
    } on DioException catch (e, t) {
      return _handleException(e, t);
    }
  }

  Future<ApiResponseModel> delete(
    String path, {
    Object? data,
    Object? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _client.delete<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse(response);
    } on DioException catch (e, t) {
      return _handleException(e, t);
    }
  }
}
