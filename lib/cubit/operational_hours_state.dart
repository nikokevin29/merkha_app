part of 'operational_hours_cubit.dart';

abstract class OperationalHoursState extends Equatable {
  const OperationalHoursState();

  @override
  List<Object> get props => [];
}

class OperationalHoursInitial extends OperationalHoursState {}


class OperationalHoursListLoaded extends OperationalHoursState {
  final List<OperationalHours> operational;

  OperationalHoursListLoaded(this.operational);

  @override
  List<Object> get props => [operational];
}


class OperationalHoursLoadFailed extends OperationalHoursState {
  final String message;

  OperationalHoursLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}