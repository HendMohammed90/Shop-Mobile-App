class CategoryModel {
  bool? status;
  CategoryDataModel? categoryDataMode;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryDataMode = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int? current_page;
  List<DataModel?> dataModel = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((e) {
      dataModel.add(DataModel.fromJson(e));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
