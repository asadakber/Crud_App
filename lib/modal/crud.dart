class Crud {
  final String title;
  final String description;
  final String id;

  Crud({this.title, this.description, this.id});

  Crud.fromMap(Map<String, dynamic>data, String id):
      title=data["title"],
      description=data["description"],
      id=id;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
    };
  }

}