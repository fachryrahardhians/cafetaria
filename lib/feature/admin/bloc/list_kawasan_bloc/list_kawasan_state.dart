part of 'list_kawasan_bloc.dart';

enum ListKawasanStatus { initial, loading, success, failure }

class ListKawasanState extends Equatable {
  const ListKawasanState.__(
      {this.errorMessage, this.items, required this.status});

  final ListKawasanStatus status;
  final List<KawasanRead>? items;
  final String? errorMessage;

  const ListKawasanState.initial() : this.__(status: ListKawasanStatus.initial);

  const ListKawasanState.loading() : this.__(status: ListKawasanStatus.loading);

  const ListKawasanState.success(List<KawasanRead> items)
      : this.__(
          status: ListKawasanStatus.success,
          items: items,
        );

  const ListKawasanState.failure(String errorMessage)
      : this.__(
          status: ListKawasanStatus.failure,
          errorMessage: errorMessage,
        );
  @override
  List<Object?> get props => [status, items, errorMessage];
}
