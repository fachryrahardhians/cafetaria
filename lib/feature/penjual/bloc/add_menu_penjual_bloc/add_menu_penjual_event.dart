part of 'add_menu_penjual_bloc.dart';

abstract class AddMenuPenjualEvent extends Equatable {
  const AddMenuPenjualEvent();

  @override
  List<Object> get props => [];
}

class MenuChange extends AddMenuPenjualEvent {
  final String menuName;

  const MenuChange(this.menuName);

  @override
  List<Object> get props => [menuName];
}

class DescriptionChange extends AddMenuPenjualEvent {
  final String description;

  const DescriptionChange(this.description);

  @override
  List<Object> get props => [description];
}

class KategoriChange extends AddMenuPenjualEvent {
  final String category;

  const KategoriChange(this.category);

  @override
  List<Object> get props => [category];
}

class CheckedStock extends AddMenuPenjualEvent {
  final bool checked;

  const CheckedStock(this.checked);

  @override
  List<Object> get props => [checked];
}

class HargaJualChange extends AddMenuPenjualEvent {
  final String hargaJual;

  const HargaJualChange(this.hargaJual);

  @override
  List<Object> get props => [hargaJual];
}

class TageMenuChange extends AddMenuPenjualEvent {
  final String tagmenu;

  const TageMenuChange(this.tagmenu);

  @override
  List<Object> get props => [tagmenu];
}

class AddTagMenu extends AddMenuPenjualEvent {
  final String tag;

  const AddTagMenu(this.tag);

  @override
  List<Object> get props => [tag];
}

class ChoosePhoto extends AddMenuPenjualEvent {
  final File photo;

  const ChoosePhoto(this.photo);

  @override
  List<Object> get props => [photo];
}

class UploadPhoto extends AddMenuPenjualEvent {
  final UploadProgress uploadProgress;

  const UploadPhoto(this.uploadProgress);

  @override
  List<Object> get props => [uploadProgress];
}

class CheckedRecommendedMenu extends AddMenuPenjualEvent {
  final bool checked;

  const CheckedRecommendedMenu(this.checked);

  @override
  List<Object> get props => [checked];
}

class MenuCanBooked extends AddMenuPenjualEvent {
  final bool canBooked;

  const MenuCanBooked(this.canBooked);

  @override
  List<Object> get props => [canBooked];
}

class SaveMenu extends AddMenuPenjualEvent {}

class UpdateMenu extends AddMenuPenjualEvent {
  final bool updatePhoto;
  final String photoUrl;
  final String menuId;

  const UpdateMenu(this.photoUrl,
      {required this.updatePhoto, required this.menuId});

  @override
  List<Object> get props => [updatePhoto, photoUrl, menuId];
}

class DeleteImage extends AddMenuPenjualEvent {}

class DeleteTag extends AddMenuPenjualEvent {
  final String tag;

  const DeleteTag(this.tag);

  @override
  List<Object> get props => [tag];
}
