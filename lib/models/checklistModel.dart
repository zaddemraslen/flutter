import 'package:the_notebook/models/optionModel.dart';

class checkListModel {
  String id = "";
  String text = "";
  List<optionModel> options = [];

  checkListModel(id, text, options) {
    this.id = id;
    this.text = text;
    this.options = options;
  }

  //TODO operations ? add option/ delete option?

}
