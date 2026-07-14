import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_model.freezed.dart';
part 'forum_model.g.dart';

@freezed
class ForumHallsModel with _$ForumHallsModel {
  const factory ForumHallsModel({
    required String id,
    required String name,
    String? banner,
    String? avatar,
    required int followerCount,
    String? categoryName,
    required double rate,
    List<ForumFollowerModel>? followers,
  }) = _ForumHallsModel;

  factory ForumHallsModel.fromJson(Map<String, dynamic> json) =>
      _$ForumHallsModelFromJson(json);
}

@freezed
class ForumFollowerModel with _$ForumFollowerModel {
  const factory ForumFollowerModel({
    required String id,
    String? avatarUrl,
    String? firstName,
    String? lastName,
  }) = _ForumFollowerModel;

  factory ForumFollowerModel.fromJson(Map<String, dynamic> json) =>
      _$ForumFollowerModelFromJson(json);
}

@freezed
class ForumHallModel with _$ForumHallModel {
  const factory ForumHallModel({
    required String id,
    required String name,
    String? banner,
    String? avatar,
    required int followerCount,
    required int titleCount,
    String? description,
    String? rules,
    String? categoryName,
    required double rate,
    List<ForumManagerModel>? managers,
    List<String>? tags,
  }) = _ForumHallModel;

  factory ForumHallModel.fromJson(Map<String, dynamic> json) =>
      _$ForumHallModelFromJson(json);
}

@freezed
class ForumManagerModel with _$ForumManagerModel {
  const factory ForumManagerModel({
    required String id,
    required String name,
    String? avatarUrl,
    String? speciality,
  }) = _ForumManagerModel;

  factory ForumManagerModel.fromJson(Map<String, dynamic> json) =>
      _$ForumManagerModelFromJson(json);
}

@freezed
class ForumTileModel with _$ForumTileModel {
  const factory ForumTileModel({
    required String id,
    required String title,
    String? leadText,
    String? categoryName,
    String? authorName,
    String? authorAvatar,
    DateTime? createdOn,
    required int type,
    required int commentType,
  }) = _ForumTileModel;

  factory ForumTileModel.fromJson(Map<String, dynamic> json) =>
      _$ForumTileModelFromJson(json);
}

@freezed
class ForumModel with _$ForumModel {
  const factory ForumModel({
    required String id,
    required String title,
    String? leadText,
    String? question,
    String? categoryName,
    String? authorName,
    String? authorAvatar,
    DateTime? createdOn,
    required int type,
    required int commentType,
    List<ForumMediaModel>? media,
    DateTime? updatedOn,
  }) = _ForumModel;

  factory ForumModel.fromJson(Map<String, dynamic> json) =>
      _$ForumModelFromJson(json);
}

@freezed
class ForumMediaModel with _$ForumMediaModel {
  const factory ForumMediaModel({
    required String value,
    required int type,
    String? caption,
    String? alt,
    int? height,
    int? width,
    int? size,
    int? duration,
  }) = _ForumMediaModel;

  factory ForumMediaModel.fromJson(Map<String, dynamic> json) =>
      _$ForumMediaModelFromJson(json);
}

@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    required int id,
    required String comment,
    String? authorName,
    String? authorAvatar,
    DateTime? createdOn,
    required int likeCount,
    List<CommentModel>? replies,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
