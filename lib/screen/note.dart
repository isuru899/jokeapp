class Note {
  String title;
  String text;
  String type;

  Note(this.title, this.text, this.type);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['setup'];
    text = json['punchline'];
    type = json['type'];
  }
}