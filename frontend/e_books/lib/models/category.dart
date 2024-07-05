class Category{
  final int id;
  final String name;

  Category({required this.name, required this.id});

  Map<String, dynamic> _toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  static List<Map<String, dynamic>>? toMapList(List<Category>? categories) {
    return categories?.map((category) => category._toMap()).toList();
  }

  static Category fromJson(Map<String, dynamic> json){

    return Category(
      id: json["id"] as int,
      name: json["name"],
    );

  }

}