import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

@freezed
class ApiResponseModel with _$ApiResponseModel {
  const factory ApiResponseModel({
    required dynamic data,
    required bool succeeded,
    required bool isList,
    required String? message,
    required PaginateModel? paginate,
    required List<ErrorDetailModel>? errors,
  }) = _ApiResponseModel;

  const ApiResponseModel._();

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);

  @override
  String toString() {
    return """ApiResponseModel(
  data: $data,
  succeeded: $succeeded,
  isList: $isList,
  message: $message,
  paginate: $paginate,
  errors: $errors
)""";
  }
}

@freezed
class PaginateModel with _$PaginateModel {
  const factory PaginateModel({
    required int totalCount,
    required int totalPages,
    required int pageSize,
    required int pageNumber,
  }) = _PaginateModel;

  const PaginateModel._();

  factory PaginateModel.fromJson(Map<String, dynamic> json) =>
      _$PaginateModelFromJson(json);

  @override
  String toString() {
    return """PaginateModel(
    totalCount: $totalCount,
    totalPages: $totalPages,
    pageSize: $pageSize,
    pageNumber: $pageNumber
  )""";
  }
}

@freezed
class ErrorDetailModel with _$ErrorDetailModel {
  const factory ErrorDetailModel({
    required String message,
    required int code,
  }) = _ErrorDetailModel;

  const ErrorDetailModel._();

  factory ErrorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailModelFromJson(json);

  @override
  String toString() {
    return """ErrorDetailModel(
    code: $code
    message: $message,
  )""";
  }
}
