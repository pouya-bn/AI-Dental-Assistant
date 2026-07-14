import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/media_page_params.dart';
import 'package:ava/core/providers/auth_provider.dart';
import 'package:ava/pages/about_page.dart';
import 'package:ava/pages/chat_intro_page.dart';
import 'package:ava/pages/chat_page/chat_page.dart';
import 'package:ava/pages/clinic_page/clinic_page.dart';
import 'package:ava/pages/comments_page/comments_page.dart';
import 'package:ava/pages/disease_records_page.dart';
import 'package:ava/pages/doctor_page/doctor_page.dart';
import 'package:ava/pages/edit_doctor_page/edit_doctor_page.dart';
import 'package:ava/pages/edit_user_page/edit_user_page.dart';
import 'package:ava/pages/exam_records_page.dart';
import 'package:ava/pages/faq_page.dart';
import 'package:ava/pages/favorites_page.dart';
import 'package:ava/pages/find_doctor_page/find_doctor_page.dart';
import 'package:ava/pages/forum_hall_page/forum_hall_page.dart';
import 'package:ava/pages/forum_halls_page/forum_halls_page.dart';
import 'package:ava/pages/forum_page/forum_page.dart';
import 'package:ava/pages/in_person_consult_page.dart';
import 'package:ava/pages/introduction_page.dart';
import 'package:ava/pages/login_page.dart';
import 'package:ava/pages/map_page/map_page.dart';
import 'package:ava/pages/media_page.dart';
import 'package:ava/pages/notifications_page.dart';
import 'package:ava/pages/otp_page.dart';
import 'package:ava/pages/patient_page/patient_page.dart';
import 'package:ava/pages/phone_consult_hours_page.dart';
import 'package:ava/pages/profile_page.dart';
import 'package:ava/pages/register_consult_page/register_consult_page.dart';
import 'package:ava/pages/register_doctor_page/register_doctor_page.dart';
import 'package:ava/pages/reviews_page.dart';
import 'package:ava/pages/settings_page.dart';
import 'package:ava/pages/shell_page.dart';
import 'package:ava/pages/splash_page.dart';
import 'package:ava/pages/statistics_page/statistics_page.dart';
import 'package:ava/pages/switch_account_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:go_router/go_router.dart';

part 'router.g.dart';
part 'routes.dart';
part 'transitions.dart';

final navigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'navigatorKey',
);

@riverpod
GoRouter router(RouterRef ref) {
  final notifier = ValueNotifier(AuthStatus.unknown);
  ref
    ..onDispose(notifier.dispose)
    ..listen(
      authProvider,
      (_, value) => value.whenData((status) {
        return notifier.value = status;
      }),
    );

  final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash,
    routes: _routes,
    refreshListenable: notifier,
    redirect: (_, state) {
      final status = notifier.value;
      if (!status.allowedPaths.contains(state.fullPath)) {
        return status.redirectPath;
      }
      return null;
    },
  );

  ref.onDispose(router.dispose);

  return router;
}

final _routes = [
  GoRoute(
    path: AppRoutes.splash,
    pageBuilder: _pageBuilder(const SplashPage()),
  ),
  GoRoute(
    path: AppRoutes.intro,
    pageBuilder: _pageBuilder(const IntroductionPage()),
  ),
  GoRoute(
    path: AppRoutes.login,
    pageBuilder: _pageBuilder(const LoginPage()),
  ),
  GoRoute(
    path: AppRoutes.otp,
    pageBuilder: (context, state) {
      final phone = state.extra as String;
      return _customPageBuilder(
        context,
        state,
        child: OtpPage(phone: phone),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.shell,
    pageBuilder: _pageBuilder(const ShellPage()),
  ),
  GoRoute(
    path: AppRoutes.findDoctor,
    pageBuilder: _pageBuilder(const FindDoctorPage()),
  ),
  GoRoute(
    path: AppRoutes.forum,
    pageBuilder: _pageBuilder(const ForumPage()),
  ),
  GoRoute(
    path: AppRoutes.forumHall,
    pageBuilder: (context, state) {
      final hallId = state.extra as String;
      return _customPageBuilder(
        context,
        state,
        child: ForumHallPage(hallId: hallId),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.forumHalls,
    pageBuilder: _pageBuilder(const ForumHallsPage()),
  ),
  GoRoute(
    path: AppRoutes.chat,
    pageBuilder: _pageBuilder(const ChatPage()),
  ),
  GoRoute(
    path: AppRoutes.chatIntro,
    pageBuilder: _pageBuilder(const ChatIntroPage()),
  ),
  GoRoute(
    path: AppRoutes.map,
    pageBuilder: _pageBuilder(const MapPage()),
  ),
  GoRoute(
    path: AppRoutes.doctor,
    pageBuilder: (context, state) {
      final doctorId = state.extra as String;
      return _customPageBuilder(
        context,
        state,
        child: DoctorPage(doctorId: doctorId),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.clinic,
    pageBuilder: (context, state) {
      final clinicId = state.extra as String;
      return _customPageBuilder(
        context,
        state,
        child: ClinicPage(clinicId: clinicId),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.patient,
    pageBuilder: (context, state) {
      final patientId = state.extra as String;
      return _customPageBuilder(
        context,
        state,
        child: PatientPage(patientId: patientId),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.reviews,
    pageBuilder: _pageBuilder(const ReviewsPage()),
  ),
  GoRoute(
    path: AppRoutes.notifications,
    pageBuilder: _pageBuilder(const NotificationsPage()),
  ),
  GoRoute(
    path: AppRoutes.profile,
    pageBuilder: _pageBuilder(const ProfilePage()),
  ),
  GoRoute(
    path: AppRoutes.editUser,
    pageBuilder: _pageBuilder(const EditUserPage()),
  ),
  GoRoute(
    path: AppRoutes.editDoctor,
    pageBuilder: _pageBuilder(const EditDoctorPage()),
  ),
  GoRoute(
    path: AppRoutes.favorites,
    pageBuilder: _pageBuilder(const FavoritesPage()),
  ),
  GoRoute(
    path: AppRoutes.settings,
    pageBuilder: _pageBuilder(const SettingsPage()),
  ),
  GoRoute(
    path: AppRoutes.about,
    pageBuilder: _pageBuilder(const AboutPage()),
  ),
  GoRoute(
    path: AppRoutes.faq,
    pageBuilder: _pageBuilder(const FaqPage()),
  ),
  GoRoute(
    path: AppRoutes.diseaseRecords,
    pageBuilder: _pageBuilder(const DiseaseRecordsPage()),
  ),
  GoRoute(
    path: AppRoutes.examRecords,
    pageBuilder: _pageBuilder(const ExamRecordsPage()),
  ),
  GoRoute(
    path: AppRoutes.media,
    pageBuilder: (context, state) {
      final params = state.extra as MediaPageParams;
      return _customPageBuilder(
        context,
        state,
        child: MediaPage(params: params),
      );
    },
  ),
  GoRoute(
    path: AppRoutes.comments,
    pageBuilder: _pageBuilder(const CommentsPage()),
  ),
  GoRoute(
    path: AppRoutes.registerDoctor,
    pageBuilder: _pageBuilder(const RegisterDoctorPage()),
  ),
  GoRoute(
    path: AppRoutes.registerConsult,
    pageBuilder: _pageBuilder(const RegisterConsultPage()),
  ),
  GoRoute(
    path: AppRoutes.phoneConsultHours,
    pageBuilder: _pageBuilder(const PhoneConsultHoursPage()),
  ),
  GoRoute(
    path: AppRoutes.inPersonConsult,
    pageBuilder: _pageBuilder(const InPersonConsultPage()),
  ),
  GoRoute(
    path: AppRoutes.switchAccount,
    pageBuilder: _pageBuilder(const SwitchAccountPage()),
  ),
  GoRoute(
    path: AppRoutes.statistics,
    pageBuilder: _pageBuilder(const StatisticsPage()),
  ),
];
