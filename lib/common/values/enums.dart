import 'package:ava/core/models/message_model.dart';
import 'package:ava/core/router/router.dart';

enum AuthStatus {
  unknown(
    redirectPath: AppRoutes.splash,
    allowedPaths: [
      AppRoutes.splash,
    ],
  ),
  intro(
    redirectPath: AppRoutes.intro,
    allowedPaths: [
      AppRoutes.intro,
    ],
  ),
  unauthenticated(
    redirectPath: AppRoutes.login,
    allowedPaths: [
      AppRoutes.login,
      AppRoutes.otp,
    ],
  ),
  authenticated(
    redirectPath: AppRoutes.shell,
    allowedPaths: [
      AppRoutes.shell,
      AppRoutes.findDoctor,
      AppRoutes.forum,
      AppRoutes.forumHall,
      AppRoutes.forumHalls,
      AppRoutes.chat,
      AppRoutes.chatIntro,
      AppRoutes.map,
      AppRoutes.doctor,
      AppRoutes.clinic,
      AppRoutes.patient,
      AppRoutes.reviews,
      AppRoutes.notifications,
      AppRoutes.profile,
      AppRoutes.editUser,
      AppRoutes.editDoctor,
      AppRoutes.favorites,
      AppRoutes.settings,
      AppRoutes.about,
      AppRoutes.faq,
      AppRoutes.diseaseRecords,
      AppRoutes.examRecords,
      AppRoutes.media,
      AppRoutes.comments,
      AppRoutes.registerDoctor,
      AppRoutes.registerConsult,
      AppRoutes.phoneConsultHours,
      AppRoutes.inPersonConsult,
      AppRoutes.switchAccount,
      AppRoutes.statistics,
    ],
  );

  const AuthStatus({
    required this.redirectPath,
    required this.allowedPaths,
  });

  final String redirectPath;
  final List<String> allowedPaths;
}

enum FindDoctorType {
  all,
  doctor,
  clinic,
}

enum FindDoctorRate {
  all,
  fiveStar,
  fourStar,
  threeStarAndLess,
}

enum FindDoctorSpecialty {
  all,
  orthodontics,
  rootTreatment,
  prosthesisAndImplant,
  radiology,
}

enum MessageType {
  picture(id: 0, name: 'Picture'),
  video(id: 1, name: 'Video'),
  audio(id: 2, name: 'Audio'),
  pdf(id: 3, name: 'Pdf'),
  word(id: 4, name: 'Word'),
  powerPoint(id: 5, name: 'PowerPoint'),
  text(id: 6, name: 'Text');

  MessageTypeModel get toModel => MessageTypeModel(
        id: id,
        name: name,
      );

  const MessageType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

enum ForumType {
  media(id: 0, name: 'Media'),
  blog(id: 1, name: 'Blog'),
  article(id: 2, name: 'Article');

  const ForumType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

enum CommentType {
  allowEveryone(id: 0, name: 'AllowEveryone'),
  allowDentist(id: 1, name: 'AllowDentist'),
  justAnswer(id: 2, name: 'JustAnswer');

  const CommentType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

enum ActionBarType {
  like,
  comment,
  download,
  share,
  follow,
  info,
}
