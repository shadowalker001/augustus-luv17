class AppUser {
  String dataTitle;
  String name;
  int age;
  String description;
  String location;
  int likeCount;
  List<String> images;
  List<String> tags;

  AppUser.fromJSON(Map<String, dynamic> data)
      : dataTitle = stringer(data['dataTitle']),
        name = stringer(data['name']),
        location = stringer(data['name']),
        description = stringer(data['description']),
        age = inter(data['age']),
        likeCount = inter(data['likeCount']),
        images = listString(data['images']),
        tags = listString(data['tags']);
}

String stringer(val, {String d = ''}) {
  if (val is String) return val;
  return d;
}

int inter(val, {int d = 0}) {
  try {
    return int.parse(val.toString());
  } catch (e) {
    return d;
  }
}

List<String> listString(val) {
  try {
    return List<String>.from(val);
  } catch (e) {
    return [];
  }
}

Map<String, dynamic> maper(val) {
  try {
    return Map<String, dynamic>.from(val);
  } catch (e) {
    return {};
  }
}

class CommonAssets {
  static String location = "assets/icons/location.png";
  static String user = "assets/icons/user.png";
  static String message = "assets/icons/message.png";
  static String home = "assets/icons/home.png";

  static String bell = "assets/icons/bell.png";
  static String star = "assets/icons/star.png";
  static String slide1 = "assets/images/image-1.png";
  static String slide2 = "assets/images/image-2.png";
  static String slide3 = "assets/images/image-3.png";
}
