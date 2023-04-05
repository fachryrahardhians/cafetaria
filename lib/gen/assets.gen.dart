/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.png');

  /// File path: assets/images/card_overlay_orange.png
  AssetGenImage get cardOverlayOrange =>
      const AssetGenImage('assets/images/card_overlay_orange.png');

  /// File path: assets/images/ic_grfx_warning.png
  AssetGenImage get icGrfxWarning =>
      const AssetGenImage('assets/images/ic_grfx_warning.png');

  /// File path: assets/images/map.png
  AssetGenImage get icMap => const AssetGenImage('assets/images/map.png');

  /// File path: assets/images/ill_cafetaria.png
  AssetGenImage get illCafetaria =>
      const AssetGenImage('assets/images/ill_cafetaria.png');

  /// File path: assets/images/ill_cafetaria_banner1.png
  AssetGenImage get illCafetariaBanner1 =>
      const AssetGenImage('assets/images/ill_cafetaria_banner1.png');

  /// File path: assets/images/ill_cafetaria_banner2.png
  AssetGenImage get illCafetariaBanner2 =>
      const AssetGenImage('assets/images/ill_cafetaria_banner2.png');

  /// File path: assets/images/ill_food.png
  AssetGenImage get illFood =>
      const AssetGenImage('assets/images/ill_food.png');

  /// File path: assets/images/ill_home.png
  AssetGenImage get illHome =>
      const AssetGenImage('assets/images/ill_home.png');

  /// File path: assets/images/ill_merchants.png
  AssetGenImage get illMerchants =>
      const AssetGenImage('assets/images/ill_merchants.png');

  /// File path: assets/images/ill_rate.png
  AssetGenImage get illRate =>
      const AssetGenImage('assets/images/ill_rate.png');

  /// File path: assets/images/ill_sad.png
  AssetGenImage get illSad => const AssetGenImage('assets/images/ill_sad.png');

  /// File path: assets/images/ill_wait.png
  AssetGenImage get illWait =>
      const AssetGenImage('assets/images/ill_wait.png');

  /// File path: assets/images/info-1.png
  AssetGenImage get info1 => const AssetGenImage('assets/images/info-1.png');

  /// File path: assets/images/info-2.png
  AssetGenImage get info2 => const AssetGenImage('assets/images/info-2.png');

  /// File path: assets/images/maskgroup.png
  AssetGenImage get maskgroup =>
      const AssetGenImage('assets/images/maskgroup.png');

  /// File path: assets/images/offer_1.png
  AssetGenImage get offer1 => const AssetGenImage('assets/images/offer_1.png');

  AssetGenImage get user => const AssetGenImage('assets/images/grfx_user.png');

  /// File path: assets/images/offer_2.png
  AssetGenImage get offer2 => const AssetGenImage('assets/images/offer_2.png');

  /// File path: assets/images/offer_3.png
  AssetGenImage get offer3 => const AssetGenImage('assets/images/offer_3.png');

  /// File path: assets/images/product-1.png
  AssetGenImage get product1 =>
      const AssetGenImage('assets/images/product-1.png');

  /// File path: assets/images/product-2.png
  AssetGenImage get product2 =>
      const AssetGenImage('assets/images/product-2.png');

  /// File path: assets/images/product-3.png
  AssetGenImage get product3 =>
      const AssetGenImage('assets/images/product-3.png');
  AssetGenImage get register =>
      const AssetGenImage('assets/images/grfx_register2.png');
  AssetGenImage get login =>
      const AssetGenImage('assets/images/grfx_login2.png');
  AssetGenImage get calClose =>
      const AssetGenImage('assets/icons/cal_close.png');
  AssetGenImage get calOpen => const AssetGenImage('assets/icons/cal_open.png');
  
    AssetGenImage get logo => const AssetGenImage('assets/images/Logo.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale = 1.0,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;
}
