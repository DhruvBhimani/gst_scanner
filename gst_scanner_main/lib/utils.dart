import 'package:gst_scanner/models/gst_user_models.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

sendmailtodispatcher() async {

  final smtpServer = gmail('tshadhruv@gmail.com', 'djcizsuegxlsdzwl');
  final message = Message()
    ..from = Address('tshadhruv@gmail.com', 'gst')
    ..recipients.add('dhruvbhimani77.77.db@gmail.com')
    ..subject = 'Welcome to gst_app'
    ..html =
        '<h1>Welcome! Login into your account</h1>';
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