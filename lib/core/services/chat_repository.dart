import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/message_model.dart';
import 'package:ava/core/utils/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  ChatRepository(this.ref);

  final Ref ref;
  final _messagesSubject = BehaviorSubject<List<AvaMessageModel>>.seeded([]);
  final _messages = <AvaMessageModel>[];

  Stream<List<AvaMessageModel>> get chatStream => _messagesSubject.stream;

  Future<void> initialize(List<AvaMessageModel> messages) async {
    try {
      _addMessages(messages);
    } catch (e) {
      logger.e('Failed to initialize chat: $e');
    }
  }

  void _addMessages(List<AvaMessageModel> messages) {
    _messages.addAll(messages);
    _messagesSubject.add(List.from(_messages));
  }

  void _addMessage(AvaMessageModel message) {
    _messages.insert(0, message);
    _messagesSubject.add(List.from(_messages));
  }

  bool shouldType(int messageId) {
    return false;
  }

  bool shouldShowButtons(int messageId) {
    return false;
  }

  void _sendMessage({
    required int id,
    required MessageTypeModel type,
    required DateTime createdAt,
    required String message,
    File? file,
  }) async {
    _addMessage(
      AvaMessageModel(
        isUserMessage: true,
        id: id,
        type: type,
        createdAt: createdAt,
        message: message,
        file: file,
      ),
    );
    // ref.read(socketProvider).send(
    //       event: AppStrings.chatEvent,
    //       data: message.toJson(),
    //     );
  }

  void sendText(String message) async {
    try {
      _sendMessage(
        id: 0, // TODO: Add id
        type: MessageType.text.toModel,
        createdAt: DateTime.now(),
        message: message,
      );
    } catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در ارسال پیام',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
  }

  void sendPicture(File file) async {
    try {
      _sendMessage(
        id: 0,
        // TODO: Add id
        type: MessageType.picture.toModel,
        createdAt: DateTime.now(),
        file: file,
        message: file.path.split('/').last,
      );
    } catch (e) {
      logger.e(e);
      AppToast.showError(
        title: 'خطا در ارسال پیام',
        description: 'لطفا دوباره تلاش کنید',
      );
    }
  }

  Future<void> saveAsPdf(AvaMessageModel message) async {
    try {
      if (message.fileUrl == null) {
        return;
      }

      final pdf = pw.Document();
      final image =
          message.fileUrl != null ? await networkImage(message.fileUrl!) : null;

      final theme = pw.ThemeData.withFont(
        base: pw.Font.ttf(
          await rootBundle.load('assets/fonts/AbarLowFaNum-Regular.ttf'),
        ),
      );

      pdf.addPage(
        pw.MultiPage(
          pageTheme: pw.PageTheme(
            theme: theme,
            pageFormat: PdfPageFormat.a4,
            textDirection: pw.TextDirection.rtl,
          ),
          build: (context) => [
            if (image != null) pw.Image(image),
            pw.Text(
              message.message,
              style: const pw.TextStyle(
                fontSize: 20,
                color: PdfColors.black,
              ),
            ),
          ],
        ),
      ); // Page

      final tempDir = await getTemporaryDirectory();
      final tempFile =
          File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf');
      final pdfFile = await tempFile.writeAsBytes(await pdf.save());
      await saveFile(pdfFile);
    } catch (e, t) {
      logger.e(e, stackTrace: t);
    } // Page
  }
}
