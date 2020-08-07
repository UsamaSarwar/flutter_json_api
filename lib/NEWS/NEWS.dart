class NEWS {
  String title;
  String text;
  String date;
  String pic;

  NEWS(this.title, this.text, this.date, this.pic);

  NEWS.fromJson(Map<String, dynamic> json) {
    title = json['Khabar_Title'];
    text = json['Khabar_Details'];
    date = json['Khabar_Date'];
    pic = json['Pic'];
  }
}
