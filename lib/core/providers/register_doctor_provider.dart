import 'package:ava/core/models/address_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/providers/basic_provider.dart';
import 'package:ava/core/services/register_doctor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_doctor_provider.g.dart';

@riverpod
RegisterDoctorRepository registerDoctorRepository(
    RegisterDoctorRepositoryRef ref) {
  return RegisterDoctorRepository(ref);
}

@riverpod
class RegisterDoctor extends _$RegisterDoctor {
  RegisterDoctorRepository get _repo =>
      ref.watch(registerDoctorRepositoryProvider);

  GenderModel? gender;
  AddressModel? address;

  @override
  Future<void> build() async {
    await ref.watch(basicProvider.future);
    final basicNotifier = ref.watch(basicProvider.notifier);
    gender = basicNotifier.gender;
    address = basicNotifier.address;
  }

  void updateAddress(AddressModel? address) {
    this.address = address;
  }
}
