import 'package:ava/core/models/label_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required Widget child,
    LabelModel? label,
  }) = _ItemModel;
}
