import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

/// simple wrapper around CachedNetworkImage that provides any boilerplate we need for images in the app
class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fallbackImage,
    this.fit = BoxFit.cover,
    this.iconColor,
  });
  final String url;
  final double? height, width;
  final BoxFit fit;
  final Color? iconColor;

  /// image to be displayed when the image is not available
  final Widget? fallbackImage;

  @override
  Widget build(BuildContext context) {
    var secureUrl = url;
    if (url.contains('http://')) {
      secureUrl = secureUrl.replaceAll('http://', 'https://');
    }

    if (url.isEmpty) {
      return Container(
        height: context.getHeight(0.060),
        padding: const EdgeInsets.all(Insets.dim_8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.textBodyColor),
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: Icon(
            Icons.person,
            color: iconColor ?? AppColors.white,
            size: Insets.dim_32,
          ),
        ),
      );
    }

    if (secureUrl.split('.').last == 'svg') {
      Log().debug('the url is $url');

      return CircleAvatar(
        backgroundColor: AppColors.grey.withOpacity(.05),
        child: SvgPicture.network(
          secureUrl,
          height: height,
          width: width,
        ),
      );
    }
    return Container(
      height: Insets.dim_40,
      width: Insets.dim_40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.appPrimaryColor,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: secureUrl,
        fit: fit,
        height: height,
        width: width,
        progressIndicatorBuilder: (_, s, i) =>
            CupertinoActivityIndicator.partiallyRevealed(
          progress: i.progress ?? 1,
        ),
        errorWidget: (_, s, ___) =>
            fallbackImage ??
            LocalSvgImage(
              pendingIcon,
              fit: fit,
              height: height,
              width: width,
            ),
        fadeInDuration: 1.seconds,
      ),
    );
  }
}

class LocalImage extends StatelessWidget {
  const LocalImage(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.semanticLabel,
    this.color,
    this.fit = BoxFit.cover,
  });
  final String image;
  final String? semanticLabel;
  final double? height, width;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      height: height,
      color: color,
      width: width,
      semanticLabel: '',
    );
  }
}

class LocalSvgImage extends StatelessWidget {
  const LocalSvgImage(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.colorFilter,
    this.fit = BoxFit.cover,
    this.color,
  });
  final String image;
  final double? height, width;
  final BoxFit fit;
  final ColorFilter? colorFilter;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: fit,
      height: height,
      width: width,
      colorFilter: colorFilter,
    );
  }
}
