import 'package:ava/core/services/exam_records_repository.dart';
import 'package:ava/core/utils/format.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exam_records_provider.g.dart';

@riverpod
ExamRecordsRepository examRecordsRepository(ExamRecordsRepositoryRef ref) {
  return ExamRecordsRepository(ref);
}

@riverpod
class ExamRecords extends _$ExamRecords {
  late final ExamRecordsRepository _examRecordsRepo;

  @override
  Future<void> build() async {
    _examRecordsRepo = ref.watch(examRecordsRepositoryProvider);
  }
}

@Riverpod(keepAlive: true)
class ExamRecordsFilter extends _$ExamRecordsFilter {
  final sorts = ['جدیدترین', 'قدیمی‌ترین'];
  final types = ['تلفنی', 'متنی', 'حضوری'];

  @override
  ExamRecordsFilterState build() {
    return const ExamRecordsFilterState();
  }

  void setSort(String value) {
    state = state.copyWith(sort: () => value);
  }

  void setType(String value) {
    state = state.copyWith(type: () => value);
  }

  void setStartDate(Jalali jalali) {
    state = state.copyWith(
      startDateJalali: () => formatJalali(jalali),
      startDateGregorian: () => formatGregorian(jalali.toGregorian()),
    );
  }

  void setEndDate(Jalali jalali) {
    state = state.copyWith(
      endDateJalali: () => formatJalali(jalali),
      endDateGregorian: () => formatGregorian(jalali.toGregorian()),
    );
  }

  void removeSort() {
    state = state.copyWith(sort: () => null);
  }

  void removeType() {
    state = state.copyWith(type: () => null);
  }

  void removeStartDate() {
    state = state.copyWith(
      startDateJalali: () => null,
      startDateGregorian: () => null,
    );
  }

  void removeEndDate() {
    state = state.copyWith(
      endDateJalali: () => null,
      endDateGregorian: () => null,
    );
  }

  void clear() {
    state = const ExamRecordsFilterState();
  }
}

class ExamRecordsFilterState {
  final String? sort;
  final String? type;
  final String? startDateJalali;
  final String? startDateGregorian;
  final String? endDateJalali;
  final String? endDateGregorian;

  const ExamRecordsFilterState({
    this.sort,
    this.type,
    this.startDateJalali,
    this.startDateGregorian,
    this.endDateJalali,
    this.endDateGregorian,
  });

  ExamRecordsFilterState copyWith({
    String? Function()? sort,
    String? Function()? type,
    String? Function()? startDateJalali,
    String? Function()? startDateGregorian,
    String? Function()? endDateJalali,
    String? Function()? endDateGregorian,
  }) {
    return ExamRecordsFilterState(
      sort: sort?.call() ?? this.sort,
      type: type?.call() ?? this.type,
      startDateJalali: startDateJalali?.call() ?? this.startDateJalali,
      startDateGregorian: startDateGregorian?.call() ?? this.startDateGregorian,
      endDateJalali: endDateJalali?.call() ?? this.endDateJalali,
      endDateGregorian: endDateGregorian?.call() ?? this.endDateGregorian,
    );
  }
}
