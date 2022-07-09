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

  /// File path: assets/images/card_overlay_orange.png
  AssetGenImage get cardOverlayOrange =>
      const AssetGenImage('assets/images/card_overlay_orange.png');

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

  /// File path: assets/images/maskgroup.png
  AssetGenImage get maskgroup =>
      const AssetGenImage('assets/images/maskgroup.png');

  /// File path: assets/images/offer_1.png
  AssetGenImage get offer1 => const AssetGenImage('assets/images/offer_1.png');

  /// File path: assets/images/offer_2.png
  AssetGenImage get offer2 => const AssetGenImage('assets/images/offer_2.png');

  /// File path: assets/images/offer_3.png
  AssetGenImage get offer3 => const AssetGenImage('assets/images/offer_3.png');
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
    double? scale,
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

  String get keyName => _assetName;
}
