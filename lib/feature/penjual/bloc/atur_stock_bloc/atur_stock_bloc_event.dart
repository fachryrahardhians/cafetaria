part of 'atur_stock_bloc_bloc.dart';

class AturStockBlocEvent extends Equatable {
  const AturStockBlocEvent();

  @override
  List<Object> get props => [];
}

class AturStok extends AturStockBlocEvent {
  final MenuModel stokBarang;

  const AturStok(this.stokBarang);

  @override
  List<Object> get props => [stokBarang];
}

class AturStokJumlah extends AturStockBlocEvent {
  final String qty;

  const AturStokJumlah(this.qty);

  @override
  List<Object> get props => [qty];
}

class AturStokRestok extends AturStockBlocEvent {
  final bool canReStok;

  const AturStokRestok(this.canReStok);

  @override
  List<Object> get props => [canReStok];
}

class AturStokTersedia extends AturStockBlocEvent {
  final bool isAvailable;

  const AturStokTersedia(this.isAvailable);

  @override
  List<Object> get props => [isAvailable];
}

class AturStokTime extends AturStockBlocEvent {
  final String time;

  const AturStokTime(this.time);

  @override
  List<Object> get props => [time];
}

class AturStokRestokType extends AturStockBlocEvent {
  final String restokTipe;

  const AturStokRestokType(this.restokTipe);

  @override
  List<Object> get props => [restokTipe];
}
