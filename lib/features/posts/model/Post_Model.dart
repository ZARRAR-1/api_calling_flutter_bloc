/// userId : 1
/// id : 1
/// title : "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
/// body : "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"

//Used Android Studio's Plugin JsonToDart to generate this model class
class PostModel {
  PostModel({
      required num userId,
      required num id,
      required String title,
      required String body,}){

    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
}

  PostModel.fromJson(dynamic json) { // Returns PostModel Object from a Processed String to a Json Object
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }
  late final num _userId;
  late final num _id;
  late final String _title;
  late final String _body;

PostModel copyWith({  required num userId,
  required num id,
  required String title,
  required String body,
}) => PostModel(  userId: userId,
  id: id,
  title: title,
  body: body,
);
  num get userId => _userId;
  num get id => _id;
  String get title => _title;
  String get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}