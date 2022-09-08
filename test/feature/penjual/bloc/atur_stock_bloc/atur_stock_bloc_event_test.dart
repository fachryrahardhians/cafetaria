import 'package:cafetaria/feature/penjual/bloc/atur_stock_bloc/atur_stock_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_repository/menu_repository.dart';

void main() {
  group("edit stok event", () {
    test("props are equals", () {
      // ignore: prefer_const_constructors
      expect(AturStockBlocEvent().props, <Object>[]);
    });
  });
  group("edit stok menu", () {
    test("supports value comparison", () {
      expect(const AturStok(MenuModel(tags: [])),
          const AturStok(MenuModel(tags: [])));
    });
    test("props are equals", () {
      expect(const AturStok(MenuModel(tags: [])).props,
          const AturStok(MenuModel(tags: [])).props);
    });
  });

  group("Jumlah Stok change", () {
    test("supports value comparison", () {
      expect(const AturStokJumlah("12"), const AturStokJumlah("12"));
    });
    test("props are equals", () {
      expect(
          const AturStokJumlah("12").props, const AturStokJumlah("12").props);
    });
  });

    group("IsRestock change", () {
    test("supports value comparison", () {
      expect(const AturStokRestok(true), const AturStokRestok(true));
    });
    test("props are equals", () {
      expect(
          const AturStokRestok(true).props, const AturStokRestok(true).props);
    });
  });

      group("IsAvailable change", () {
    test("supports value comparison", () {
      expect(const AturStokTersedia(false), const AturStokTersedia(false));
    });
    test("props are equals", () {
      expect(
          const AturStokTersedia(true).props, const AturStokTersedia(true).props);
    });
  });

    group("Jumlah Stok change", () {
    test("supports value comparison", () {
      expect(const AturStokTime("12:20"), const AturStokTime("12:20"));
    });
    test("props are equals", () {
      expect(
          const AturStokTime("12:20").props, const AturStokTime("12:20").props);
    });
  });
    group("Jumlah Stok change", () {
    test("supports value comparison", () {
      expect(const AturStokRestokType("hari"), const AturStokRestokType("hari"));
    });
    test("props are equals", () {
      expect(
          const AturStokRestokType("bulan").props, const AturStokRestokType("bulan").props);
    });
  });
}
