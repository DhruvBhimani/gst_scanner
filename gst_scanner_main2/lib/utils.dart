import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:gst_scanner/models/gst_user_models.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_utils/file_utils.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:open_filex/open_filex.dart';

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 2),
  ));
}

sendmailtodispatcher() async {
  final smtpServer = gmail('tshadhruv@gmail.com', 'djcizsuegxlsdzwl');
  final message = Message()
    ..from = Address('tshadhruv@gmail.com', 'gst')
    ..recipients.add('dhruvbhimani77.77.db@gmail.com')
    ..subject = 'Welcome to gst_app'
    ..html = '<h1>Welcome! Login into your account</h1>';
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    // print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

mailpdf(pw.Document pdf, String email) async {
  String dirloc = (await getTemporaryDirectory()).path;

  final file = File("${dirloc}GSTDetails.pdf");
  await file.writeAsBytes(await pdf.save());
  final smtpServer = gmail('tshadhruv@gmail.com', 'djcizsuegxlsdzwl');
  final message = Message()
    ..from = Address('tshadhruv@gmail.com', 'gst')
    ..recipients.add('$email')
    ..subject = 'GST Details'
    ..attachments = [FileAttachment(file)];
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    // print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  await file.delete();
}

downloadpdf(pw.Document pdf) async {
  Dio dio = Dio();

  final status = await Permission.storage.request();
  if (status.isGranted) {
    String dirloc = "";
    // if (Platform.isAndroid) {
    //   dirloc = "/sdcard/download/";
    // } else {
    dirloc = (await getApplicationDocumentsDirectory()).path;
    // }

    try {
      FileUtils.mkdir([dirloc]);
      // await dio.download(pdfUrl, dirloc + convertCurrentDateTimeToString() + ".pdf",
      //     onReceiveProgress: (receivedBytes, totalBytes) {
      //   print('here 1');
      //       setState(() {
      //         downloading = true;
      //         progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
      //         print(progress);
      //       });
      //       print('here 2');
      //     });
      final file = File(dirloc +
          "${DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString()}.pdf");
      await file.writeAsBytes(await pdf.save());
      // launchUrlString(file.path);
      OpenFilex.open(file.path);
    } catch (e) {
      print('catch catch catch');
      print(e);
    }

    //   setState(() {
    //     downloading = false;
    //     progress = "Download Completed.";
    //     path = dirloc + convertCurrentDateTimeToString() + ".pdf";
    //   });
    //   print(path);
    //   print('here give alert-->completed');
    // } else {
    //   setState(() {
    //     progress = "Permission Denied!";
    //     _onPressed = () {
    //       downloadFile();
    //     };
    //   });
  }
}
