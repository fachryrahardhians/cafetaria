import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/penjual/model/category_input.dart';
import 'package:cafetaria/feature/penjual/model/desc_input.dart';
import 'package:cafetaria/feature/penjual/model/harga_input.dart';
import 'package:cafetaria/feature/penjual/model/menu_input.dart';
import 'package:cafetaria/feature/penjual/model/tag_input.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'add_menu_penjual_event.dart';
part 'add_menu_penjual_state.dart';

class AddMenuPenjualBloc
    extends Bloc<AddMenuPenjualEvent, AddMenuPenjualState> {
  AddMenuPenjualBloc({
    required CloudStorage cloudStorage,
    required MenuRepository menuRepository,
  })  : _cloudStorage = cloudStorage,
        _menuRepository = menuRepository,
        super(const AddMenuPenjualState()) {
    on<MenuChange>(_menuChange);
    on<DescriptionChange>(_descriptionChange);
    on<KategoriChange>(_kategoriChange);
    on<CheckedStock>(_checkedStock);
    on<HargaJualChange>(_hargaJualChange);
    on<JumlahStokChange>(_jumlahStokChange);
    on<AddTagMenu>(_addTagMenu);
    on<TageMenuChange>(_tagMenuChange);
    on<ChoosePhoto>(_choosePhoto);
    on<CheckedRecommendedMenu>(_checkedRecommendedMenu);
    on<MenuCanBooked>(_checkedBookedMenu);
    on<UploadPhoto>(_uploadPhoto);
    on<SaveMenu>(_saveMenu);
    on<UpdateMenu>(_updateMenu);
    on<CheckedFoodKit>(_checkedFoodKit);
    on<DeleteImage>(_deleteImage);
    on<DeleteTag>(_deleteTag);
  }

  final CloudStorage _cloudStorage;
  final MenuRepository _menuRepository;
  final _uuid = const Uuid();

  StreamSubscription? _uploadTaskSubscription;

  //dispose
  @override
  Future<void> close() {
    _uploadTaskSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _menuChange(
    MenuChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final menu = MenuInput.dirty(event.menuName);

    emit(state.copyWith(
      status: Formz.validate([menu]),
      menuInput: menu,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _descriptionChange(
    DescriptionChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final desc = DeskripsiInput.dirty(event.description);

    emit(state.copyWith(
      status: Formz.validate([desc]),
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: desc,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _kategoriChange(
    KategoriChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final cat = CategoryInput.dirty(event.category);

    emit(state.copyWith(
      status: Formz.validate([cat]),
      menuInput: state.menuInput,
      categoryInput: cat,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _checkedStock(
    CheckedStock event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: event.checked,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _hargaJualChange(
    HargaJualChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final harga = HargaInput.dirty(event.hargaJual);

    emit(state.copyWith(
      status: Formz.validate([harga]),
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: harga,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _jumlahStokChange(
    JumlahStokChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      stok: event.jumlahStok,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _addTagMenu(
    AddTagMenu event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    var tagging = <String>[];

    // add tagging
    tagging.addAll(state.tagging);
    tagging.add(state.tagInput.value);

    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _choosePhoto(
    ChoosePhoto event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    ///TODO(BURHAN): ADD METHOD TO UPLOAD IMAGE AND GET URL IMAGE

    // final extension = event.photo.path.extension();
    final fileName = _uuid.v4();
    _uploadTaskSubscription?.cancel();
    _uploadTaskSubscription = _cloudStorage
        .uploadImage(event.photo, path: 'images/menu/$fileName')
        .listen(
      (uploadProgress) {
        add(UploadPhoto(uploadProgress));
      },
    );

    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: event.photo,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
      uploadProgress: state.uploadProgress,
    ));
  }

  FutureOr<void> _checkedRecommendedMenu(
    CheckedRecommendedMenu event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: event.checked,
      uploadProgress: state.uploadProgress,
    ));
  }

  FutureOr<void> _checkedBookedMenu(
    MenuCanBooked event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      tagInput: state.tagInput,
      hargaInput: state.hargaInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: state.imageUrl,
      uploadProgress: state.uploadProgress,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: event.canBooked,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _checkedFoodKit(
    CheckedFoodKit event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
        status: state.status,
        menuInput: state.menuInput,
        categoryInput: state.categoryInput,
        deskripsiInput: state.deskripsiInput,
        tagInput: state.tagInput,
        hargaInput: state.hargaInput,
        tagging: state.tagging,
        image: state.image,
        imageUrl: state.imageUrl,
        uploadProgress: state.uploadProgress,
        checkStockAccepted: state.checkStockAccepted,
        checkMenuBookedAccepted: state.checkMenuBookedAccepted,
        checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
        foodKit: event.checked));
  }

  FutureOr<void> _uploadPhoto(
    UploadPhoto event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      imageUrl: event.uploadProgress.downloadUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
      uploadProgress: event.uploadProgress,
    ));
  }

  FutureOr<void> _tagMenuChange(
    TageMenuChange event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final tag = TagInput.dirty(event.tagmenu);

    emit(state.copyWith(
      status: Formz.validate([tag]),
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: tag,
      tagging: state.tagging,
      image: state.image,
      uploadProgress: state.uploadProgress,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  Future<void> _saveMenu(
    SaveMenu event,
    Emitter<AddMenuPenjualState> emit,
  ) async {
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        menuInput: state.menuInput,
        categoryInput: state.categoryInput,
        deskripsiInput: state.deskripsiInput,
        hargaInput: state.hargaInput,
        tagInput: state.tagInput,
        tagging: state.tagging,
        image: state.image,
        uploadProgress: state.uploadProgress,
        imageUrl: state.imageUrl,
        checkStockAccepted: state.checkStockAccepted,
        checkMenuBookedAccepted: state.checkMenuBookedAccepted,
        checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
        foodKit: state.foodKit));
    SharedPreferences idmercahnt = await SharedPreferences.getInstance();
    String id = idmercahnt.getString("merchantId").toString();
    final menu = MenuModel(
        menuId: _uuid.v4(),
        defaultStock: int.parse(state.stok.toString()),
        merchantId: id,
        name: state.menuInput.value,
        autoResetStock: state.checkStockAccepted,
        categoryId: state.categoryInput.value,
        desc: state.deskripsiInput.value,
        image: state.uploadProgress!.downloadUrl!,
        isPreOrder: state.checkMenuBookedAccepted,
        isRecomended: state.checkMenuRecomendAccepted,
        price: int.parse(state.hargaInput.value),
        stock: int.parse(state.stok.toString()),
        tags: state.tagging,
        foodKit: state.foodKit);

    await _menuRepository.addMenu(menu);

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        menuInput: state.menuInput,
        categoryInput: state.categoryInput,
        deskripsiInput: state.deskripsiInput,
        hargaInput: state.hargaInput,
        tagInput: state.tagInput,
        tagging: state.tagging,
        image: state.image,
        uploadProgress: state.uploadProgress,
        imageUrl: state.imageUrl,
        checkStockAccepted: state.checkStockAccepted,
        checkMenuBookedAccepted: state.checkMenuBookedAccepted,
        checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
        foodKit: state.foodKit));
  }

  Future<void> _updateMenu(
    UpdateMenu event,
    Emitter<AddMenuPenjualState> emit,
  ) async {
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        menuInput: state.menuInput,
        categoryInput: state.categoryInput,
        deskripsiInput: state.deskripsiInput,
        hargaInput: state.hargaInput,
        tagInput: state.tagInput,
        tagging: state.tagging,
        image: state.image,
        uploadProgress: state.uploadProgress,
        imageUrl: state.imageUrl,
        checkStockAccepted: state.checkStockAccepted,
        checkMenuBookedAccepted: state.checkMenuBookedAccepted,
        checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
        foodKit: state.foodKit));
    SharedPreferences idmercahnt = await SharedPreferences.getInstance();
    String id = idmercahnt.getString("merchantId").toString();
    final MenuModel menu;
    if (event.updatePhoto) {
      menu = MenuModel(
          menuId: event.menuId,
          defaultStock: int.parse(state.stok.toString()),

          /// TODO(@Burhan): id merchant still hardcode
          merchantId: id,
          name: state.menuInput.value,
          autoResetStock: state.checkStockAccepted,
          categoryId: state.categoryInput.value,
          desc: state.deskripsiInput.value,
          image: state.uploadProgress!.downloadUrl!,
          isPreOrder: state.checkMenuBookedAccepted,
          isRecomended: state.checkMenuRecomendAccepted,
          price: int.parse(state.hargaInput.value),
          stock: int.parse(state.stok.toString()),
          tags: state.tagging,
          foodKit: state.foodKit);
    } else {
      menu = MenuModel(
          menuId: event.menuId,

          /// TODO(@Burhan): id merchant still hardcode
          merchantId: id,
          name: state.menuInput.value,
          autoResetStock: state.checkStockAccepted,
          categoryId: state.categoryInput.value,
          desc: state.deskripsiInput.value,
          image: event.photoUrl,
          isPreOrder: state.checkMenuBookedAccepted,
          isRecomended: state.checkMenuRecomendAccepted,
          price: int.parse(state.hargaInput.value),
          stock: 0,
          tags: state.tagging,
          foodKit: state.foodKit);
    }

    await _menuRepository.editMenu(menu);

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        menuInput: state.menuInput,
        categoryInput: state.categoryInput,
        deskripsiInput: state.deskripsiInput,
        hargaInput: state.hargaInput,
        tagInput: state.tagInput,
        tagging: state.tagging,
        image: state.image,
        uploadProgress: state.uploadProgress,
        imageUrl: state.imageUrl,
        checkStockAccepted: state.checkStockAccepted,
        checkMenuBookedAccepted: state.checkMenuBookedAccepted,
        checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
        foodKit: state.foodKit));
  }

  FutureOr<void> _deleteImage(
    DeleteImage event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    unawaited(_cloudStorage.deleteImage(state.uploadProgress!.downloadUrl!));

    state.image!.delete();

    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: state.tagging,
      image: state.image,
      uploadProgress: state.uploadProgress,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
    ));
  }

  FutureOr<void> _deleteTag(
    DeleteTag event,
    Emitter<AddMenuPenjualState> emit,
  ) {
    final tag = List<String>.from(state.tagging);
    tag.removeWhere((tag) => tag == event.tag);

    emit(state.copyWith(
      status: state.status,
      menuInput: state.menuInput,
      categoryInput: state.categoryInput,
      deskripsiInput: state.deskripsiInput,
      hargaInput: state.hargaInput,
      tagInput: state.tagInput,
      tagging: tag,
      image: state.image,
      imageUrl: state.imageUrl,
      checkStockAccepted: state.checkStockAccepted,
      checkMenuBookedAccepted: state.checkMenuBookedAccepted,
      checkMenuRecomendAccepted: state.checkMenuRecomendAccepted,
      uploadProgress: state.uploadProgress,
    ));
  }
}

/// string extension
extension StringExtension on String {
  String extension() {
    return split('.').last;
  }
}
