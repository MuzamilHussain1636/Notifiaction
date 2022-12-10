class UserModel {
  final String? name;
  final String? age;

  UserModel({this.name, this.age});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        name: parsedJson['name'] ?? "",
        age: parsedJson['age'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "age": this.age
    };
  }
}