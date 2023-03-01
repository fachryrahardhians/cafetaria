part of 'days_bloc.dart';

enum DaysStatus { initial, loading, success, failure }

class DaysState extends Equatable {
  const DaysState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final DaysStatus status;
  final List<Rules>? items;
  final String? errorMessage;

  const DaysState.initial() : this.__(status: DaysStatus.initial);

  const DaysState.loading() : this.__(status: DaysStatus.loading);

  const DaysState.success(List<Rules> items)
      : this.__(
          status: DaysStatus.success,
          items: items,
        );

  const DaysState.failure(String errorMessage)
      : this.__(
          status: DaysStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  DaysState copyWith({
    DaysStatus? status,
    List<Rules>? items,
    String? errorMessage,
  }) {
    return DaysState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
