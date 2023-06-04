class StepModel {
  final int id;
  final String title;
  final int duration;
  final int price;
  DateTime endDate;

  StepModel({
    required this.endDate,
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      endDate:DateTime.parse(json["endDate"]),
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      price: json['price'],
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
    return 'StepModel{id: $id, title: $title, duration: $duration, price: $price}';
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
          endDate.minute == other.endDate.minute ;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      duration.hashCode ^
      price.hashCode ^
      endDate.hashCode ;
}
