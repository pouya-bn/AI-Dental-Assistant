import 'package:ava/common/values/imports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_consult_provider.g.dart';

@riverpod
class RegisterConsult extends _$RegisterConsult {
  @override
  RegisterConsultState build() {
    return const RegisterConsultState();
  }

  void toggleText() {
    state = state.copyWith(text: !state.text);
  }

  void togglePhone() {
    state = state.copyWith(phone: !state.phone);
  }

  void toggleInPerson() {
    state = state.copyWith(inPerson: !state.inPerson);
  }

  void toggleTerms() {
    state = state.copyWith(terms: !state.terms);
  }

  void setOtpStatus(bool status) {
    state = state.copyWith(otpSent: status);
  }

  void clear() {
    state = const RegisterConsultState();
  }

  Future<bool> sendOtp({required String phone}) async {
    try {
      if (!state.text && !state.phone && !state.inPerson) {
        AppToast.showWarning(
          title: 'لطفا روش‌های مشاوره را انتخاب کنید',
        );
        return false;
      }

      final response = await ref.read(apiProvider).post(
        'consult/sendOtp',
        formData: {'username': phone},
      );
      if (response.succeeded) {
        logger('OTP sent to $phone');
        return true;
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          AppToast.showError(
            title: 'خطا در ارسال کد',
            description: response.errors?.first.message,
          );
        } else {
          AppToast.showError(
            title: 'خطا در ارسال کد',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در ارسال کد',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
    return false;
  }

  Future<void> register({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await ref.read(apiProvider).post(
        '/register/consult',
        formData: {
          'username': phone,
          'otp': otp,
        },
      );

      if (response.succeeded) {
        // TODO: Implement logic
      } else {
        if (response.errors?.isNotEmpty ?? false) {
          AppToast.showError(
            title: 'خطا در فرآیند',
            description: response.errors?.first.message,
          );
        } else {
          AppToast.showError(
            title: 'خطا در فرآیند',
            description: 'لطفا دوباره تلاش کنید',
          );
        }
      }
    } on ApiException catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در فرآیند',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
  }
}

class RegisterConsultState {
  final bool text;
  final bool phone;
  final bool inPerson;
  final bool terms;
  final bool otpSent;

  const RegisterConsultState({
    this.text = false,
    this.phone = false,
    this.inPerson = false,
    this.terms = false,
    this.otpSent = false,
  });

  RegisterConsultState copyWith({
    bool? text,
    bool? phone,
    bool? inPerson,
    bool? terms,
    bool? otpSent,
  }) {
    return RegisterConsultState(
      text: text ?? this.text,
      phone: phone ?? this.phone,
      inPerson: inPerson ?? this.inPerson,
      terms: terms ?? this.terms,
      otpSent: otpSent ?? this.otpSent,
    );
  }
}
