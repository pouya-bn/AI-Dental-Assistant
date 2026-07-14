import 'package:ava/common/values/imports.dart';
import 'package:ava/core/app/app.dart';
import 'package:ava/core/app/observers.dart';
import 'package:ava/core/models/education_model.dart';
import 'package:ava/core/models/gender_model.dart';
import 'package:ava/core/models/user_model.dart';
import 'package:ava/core/providers/storage_provider.dart';
import 'package:ava/core/services/secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorage = await SecureStorage.instance(
    keys: {AppStrings.tokenKey},
  );

  await Future(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(GenderModelAdapter());
    Hive.registerAdapter(EducationModelAdapter());
    await [
      Hive.openBox<bool>(AppStrings.introBox),
      Hive.openBox<UserModel>(AppStrings.userBox),
      Hive.openBox<String>(AppStrings.settingsBox),
    ].wait;
  });

  runApp(
    ProviderScope(
      observers: const [AppObserver()],
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
      ],
      child: const Ava(),
    ),
  );
}
