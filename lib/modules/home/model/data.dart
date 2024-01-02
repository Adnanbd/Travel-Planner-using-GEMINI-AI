// ignore_for_file: public_member_api_docs, sort_constructors_first
class Data {
  String? from;
  String? to;
  int? days;
  VehicleType? vType;
  Data({
    this.from,
    this.to,
    this.days,
    this.vType,
  });

  Data copyWith({
    String? from,
    String? to,
    int? days,
    VehicleType? vType,
  }) {
    return Data(
      from: from ?? this.from,
      to: to ?? this.to,
      days: days ?? this.days,
      vType: vType ?? this.vType,
    );
  }
}

enum VehicleType {
  car,
  motorcycle,
  bus,
  bicycle,
  train,
  airplane,
}
