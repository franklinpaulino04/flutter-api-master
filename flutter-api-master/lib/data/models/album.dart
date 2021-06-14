/// userId : 1
/// id : 1
/// title : "quidem molestiae enim"

class Album {
  int _userId;
  int _id;
  String _title;

  int get userId => _userId;
  int get id => _id;
  String get title => _title;

  Album({
      int userId, 
      int id, 
      String title}){
    _userId = userId;
    _id = id;
    _title = title;
}

  Album.fromJson(dynamic json) {
    _userId = json["userId"];
    _id = json["id"];
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    map["id"] = _id;
    map["title"] = _title;
    return map;
  }

}