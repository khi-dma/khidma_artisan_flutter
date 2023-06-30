import 'package:get/get.dart';

class AvailableModel {
  Rx<bool> schedule;

  Rx<bool> available;
  Rx<bool> receiveOffers;
  Map<String, bool> weekday;
  String note;

  AvailableModel(
      {required this.receiveOffers,
      required this.schedule,
      required this.available,
      required this.weekday,
      required this.note});

  static AvailableModel notNull = AvailableModel(
      schedule: false.obs,
      available: true.obs,
      note: "",
      weekday: {
        "sunday": true,
        "monday": true,
        "tuesday": true,
        "wednesday": true,
        "thursday": true,
        "friday": true,
        "saturday": true,
      },
      receiveOffers: false.obs);

  factory AvailableModel.fromJson(Map<String, dynamic> json) {
    return AvailableModel(
      schedule: (json['schedule'] as bool).obs,
      available: (json['available'] as bool).obs,
      note: json['note'],
      weekday: {
        "sunday": json["sunday"],
        "monday": json["monday"],
        "tuesday": json["tuesday"],
        "wednesday": json["wednesday"],
        "thursday": json["thursday"],
        "friday": json["friday"],
        "saturday": json["saturday"],
      },
      receiveOffers: (json['receiveOffers'] as bool).obs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'schedule': schedule.value,
      'available': available.value,
      'weekday': weekday,
      'note': note,
      'receiveOffers':receiveOffers.value
    };
  }

  AvailableModel clone() => AvailableModel(
      schedule: schedule,
      available: available,
      weekday: weekday,
      note: note,
      receiveOffers: receiveOffers);
}
