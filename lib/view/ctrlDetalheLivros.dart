import 'package:get/get.dart';
import 'package:trocalivros/model/book.dart';

class CtrlDetalheLivros extends GetxController {
  final Livro livro;

  CtrlDetalheLivros(this.livro);

  void LimparCtrl(){
    Get.delete<CtrlDetalheLivros>();
  }
}