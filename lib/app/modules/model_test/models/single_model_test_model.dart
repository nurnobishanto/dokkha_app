import 'dart:convert';

import 'model_test_list_model.dart';

SingleModelTestModel singleModelTestModelFromJson(String str) =>
    SingleModelTestModel.fromJson(json.decode(str));

String singleModelTestModelToJson(SingleModelTestModel data) =>
    json.encode(data.toJson());

class SingleModelTestModel {
  final bool? status;
  final ModelTest? modelTest;

  SingleModelTestModel({
    this.status,
    this.modelTest,
  });

  factory SingleModelTestModel.fromJson(Map<String, dynamic> json) =>
      SingleModelTestModel(
        status: json["status"],
        modelTest: json["model_test"] == null
            ? null
            : ModelTest.fromJson(json["model_test"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "model_test": modelTest?.toJson(),
      };
}
