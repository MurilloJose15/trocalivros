import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

ChamarnoZap(numero) async {
  final link = WhatsAppUnilink(
    phoneNumber: '${numero}',
    text: "Olá, tenho interesse no livro, ainda está disponível?",
  );

  await canLaunchUrl(link.asUri());
}