class Todo {
  String id;
  String text;
  bool isCompleted;
  DateTime createdAt;

  Todo(this.id, this.text, this.isCompleted, this.createdAt);

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    json["id"],
    json["text"],
    json["isCompleted"] == "true",
    DateTime.parse(json["createdAt"]).toLocal()
  );

  Map<String, String> toMap() => {
    "id": id,
    "text": text,
    "isCompleted": isCompleted.toString(),
    "createdAt": createdAt.toUtc().toIso8601String()
  };
}
