import 'package:ava/common/values/imports.dart';
import 'package:ava/core/utils/cache_images.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Ava extends HookConsumerWidget {
  const Ava({super.key});

  void init() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    useEffect(() {
      init();
      return null;
    }, []);
    useAfterLayout(context, () {
      cacheImageAssets(context);
    }, []);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            themeMode: ThemeMode.light,
            theme: AppTheme.theme,
            darkTheme: AppTheme.theme,
            locale: const Locale('fa', 'IR'),
            supportedLocales: const [
              Locale('fa', 'IR'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              physics: const BouncingScrollPhysics(),
            ),
          ),
        );
      },
    );
  }
}
