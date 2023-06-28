import 'package:flutter/material.dart';

class StepModel {
  int id;
  String title;
  int duration;
  int price;
  DateTime endDate;
  bool checked;
  bool checkDemand;
  bool late;

  static StepModel notNull = StepModel(
      endDate: DateTime.now(),
      id: -1,
      title: "",
      duration: -1,
      price: -1,
      checkDemand: false,
      checked: false,
      late: false);

  StepModel({
    required this.late,
    required this.checkDemand,
    required this.checked,
    required this.endDate,
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      endDate: DateTime.parse(json["endDate"]),
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      price: json['price'],
      checkDemand: json["checkDemand"],
      checked: json["checked"],
      late: json["late"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'title': title,
      'duration': duration.toString(),
      'price': price.toString(),
      'endDate': endDate.toIso8601String(),
    };
  }


  @override
  String toString() {
    return 'StepModel{id: $id, title: $title, duration: $duration, price: $price, endDate: $endDate, checked: $checked, checkDemand: $checkDemand, late: $late}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          duration == other.duration &&
          price == other.price &&
          endDate.year == other.endDate.year &&
          endDate.day == other.endDate.day &&
          endDate.month == other.endDate.month &&
          endDate.hour == other.endDate.hour &&
          endDate.minute == other.endDate.minute;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      duration.hashCode ^
      price.hashCode ^
      endDate.hashCode;

  StepModel clone() {
    return StepModel(
        late: late,
        checkDemand: checkDemand,
        checked: checked,
        endDate: endDate,
        id: id,
        title: title,
        duration: duration,
        price: price);
  }
}
