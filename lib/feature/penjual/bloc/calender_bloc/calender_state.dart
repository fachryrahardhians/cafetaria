part of 'calender_bloc.dart';

enum CalenderStatus { initial, loading, success, failure }

class CalenderState extends Equatable {
  const CalenderState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final CalenderStatus status;
  final List<RulesDays>? items;
  final String? errorMessage;

  const CalenderState.initial() : this.__(status: CalenderStatus.initial);

  const CalenderState.loading() : this.__(status: CalenderStatus.loading);

  const CalenderState.success(List<RulesDays> items)
      : this.__(
          status: CalenderStatus.success,
          items: items,
        );

  const CalenderState.failure(String errorMessage)
      : this.__(
          status: CalenderStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  CalenderState copyWith({
    CalenderStatus? status,
    List<RulesDays>? items,
    String? errorMessage,
  }) {
    return CalenderState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
