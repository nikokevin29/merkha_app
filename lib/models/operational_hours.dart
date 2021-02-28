part of 'models.dart';

class OperationalHours extends Equatable {
  final int id;
  final String days;
  final String startTime;
  final String endTime;
  OperationalHours({
    this.id,
    this.days,
    this.startTime,
    this.endTime,
  });

  factory OperationalHours.fromJson(Map<String, dynamic> data) => OperationalHours(
        id: data['id'],
        days: data['day_name'],
        startTime: data['start_time'],
        endTime: data['end_time'],
      );
  
  @override
  List<Object> get props => [
     id,
    days,
    startTime,
    endTime,];
}
