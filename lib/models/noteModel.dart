class noteModel {
  String id = "";
  int color_id = 0;
  String creation_date = "";
  String note_content = "";
  String note_title = "";
  int position = 0;

  noteModel(id, color_id, creation_date, note_content, note_title, position) {
    this.id = id;
    this.color_id = color_id;
    this.creation_date = creation_date;
    this.note_content = note_content;
    this.note_title = note_title;
    this.position = position;
  }
}
