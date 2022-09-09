part of 'add_menu_penjual_bloc.dart';

class AddMenuPenjualState extends Equatable {
  const AddMenuPenjualState({
    this.status = FormzStatus.pure,
    this.categoryInput = const CategoryInput.pure(),
    this.deskripsiInput = const DeskripsiInput.pure(),
    this.menuInput = const MenuInput.pure(),
    this.hargaInput = const HargaInput.pure(),
    this.tagInput = const TagInput.pure(),
    this.tagging = const <String>[],
    this.image,
    this.imageUrl,
    this.checkStockAccepted = false,
    this.checkMenuRecomendAccepted = false,
    this.checkMenuBookedAccepted = false,
    this.uploadProgress,
  });

  final FormzStatus status;
  final CategoryInput categoryInput;
  final DeskripsiInput deskripsiInput;
  final MenuInput menuInput;
  final HargaInput hargaInput;
  final TagInput tagInput;
  final List<String> tagging;
  final File? image;
  final String? imageUrl;
  final bool checkStockAccepted;
  final bool checkMenuRecomendAccepted;
  final bool checkMenuBookedAccepted;
  final UploadProgress? uploadProgress;

  @override
  List<Object?> get props => [
        status,
        categoryInput,
        deskripsiInput,
        menuInput,
        hargaInput,
        tagging,
        image,
        imageUrl,
        checkStockAccepted,
        checkMenuRecomendAccepted,
        checkMenuBookedAccepted,
        uploadProgress,
        tagInput,
      ];

  AddMenuPenjualState copyWith({
    FormzStatus? status,
    CategoryInput? categoryInput,
    DeskripsiInput? deskripsiInput,
    MenuInput? menuInput,
    HargaInput? hargaInput,
    TagInput? tagInput,
    List<String>? tagging,
    File? image,
    String? imageUrl,
    bool? checkStockAccepted,
    bool? checkMenuRecomendAccepted,
    bool? checkMenuBookedAccepted,
    UploadProgress? uploadProgress,
  }) {
    return AddMenuPenjualState(
      status: status ?? this.status,
      categoryInput: categoryInput ?? this.categoryInput,
      deskripsiInput: deskripsiInput ?? this.deskripsiInput,
      menuInput: menuInput ?? this.menuInput,
      hargaInput: hargaInput ?? this.hargaInput,
      tagInput: tagInput ?? this.tagInput,
      tagging: tagging ?? this.tagging,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      checkStockAccepted: checkStockAccepted ?? this.checkStockAccepted,
      checkMenuRecomendAccepted:
          checkMenuRecomendAccepted ?? this.checkMenuRecomendAccepted,
      checkMenuBookedAccepted:
          checkMenuBookedAccepted ?? this.checkMenuBookedAccepted,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}
