import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class NetworkLoadImage extends ConsumerWidget {
  String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Widget? image;
  final Widget? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final ImageWidgetBuilder? imageBuilder;
  final BorderRadius? borderRadius;

  NetworkLoadImage({
    super.key,
    this.url,
    this.image,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.backgroundColor = const Color(0xfff2f3f3),
    this.width, // = double.infinity,
    this.height, // = double.infinity,
    this.placeholder,
    this.imageBuilder,
    this.borderRadius,
  });
  NetworkLoadImage.fill({
    super.key,
    this.url,
    this.image,
    this.errorWidget,
    this.placeholder,
    this.imageBuilder,
    this.borderRadius,
  })  : width = double.infinity,
        height = double.infinity,
        backgroundColor = const Color(0xfff2f3f3),
        fit = BoxFit.cover;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((url ?? '').isNotEmpty) {
      var uri = Uri.parse(url ?? '');
      if (uri.host.isEmpty) {
        url = '${ref.read(dioProvider).options.baseUrl}$url';
      }
    }
    // final deviceRatio = MediaQuery.of(context).devicePixelRatio;
    if (image != null && (url == null || url!.isEmpty)) {
      return image!;
    } else {
      return (url == null || url!.isEmpty)
          ? Container(
              color: backgroundColor,
              width: width,
              height: height,
              child: const Icon(
                Icons.image,
                color: Colors.grey,
              ),
            )
          : CachedNetworkImage(
              imageUrl: url ?? '',
              // key: ValueKey(url),
              httpHeaders: {
                'Authorization':
                    'Bearer ${ref.read(appController).userLogin?.accessToken}'
              },
              fit: fit,
              width: width,
              height: height,
              filterQuality: FilterQuality.high,
              imageBuilder: imageBuilder,
              placeholder: placeholder ??
                  (context, __) {
                    final image = Assets.images.placeholder.image();
                    // final colorTheme = ChatThemeData.of(context).colorTheme;

                    final shimmer = Shimmer.fromColors(
                      baseColor: const Color(0xffdbdbdb),
                      highlightColor: const Color(0xfff2f2f2),
                      child: image,
                    );
                    if (borderRadius != null) {
                      return ClipRRect(
                        borderRadius: borderRadius!,
                        child: shimmer,
                      );
                    }
                    return shimmer;
                  },
              errorWidget: (context, url, error) =>
                  errorWidget ??
                  image ??
                  Container(
                    color: backgroundColor,
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  ),
            );
    }
  }
}

class RoundedImage extends StatelessWidget {
  String? url;
  final Widget? image;
  final BoxFit? fit;
  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final Widget? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final ImageWidgetBuilder? imageBuilder;

  RoundedImage({
    super.key,
    this.url,
    this.image,
    this.fit,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderColor = Colors.white,
    this.backgroundColor = const Color(0xfff2f3f3),
    this.borderWidth = 2.0,
    this.radius = 10,
    this.margin,
    this.boxShadow,
    this.padding,
    this.errorWidget,
    this.placeholder,
    this.imageBuilder,
  });
  RoundedImage.normal({
    super.key,
    this.url,
    this.image,
    this.fit,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin,
    this.backgroundColor = const Color(0xfff2f3f3),
    this.boxShadow,
    this.padding,
    this.errorWidget,
    this.placeholder,
    this.imageBuilder,
  })  : borderColor = Colors.white,
        borderWidth = 2.0,
        radius = 10.0;

  @override
  Widget build(BuildContext context) {
    // var uri = Uri.parse(url ?? '');
    // if (uri.host.isEmpty) {
    //   url = '${getIt.get<Dio>().options.baseUrl}$url';
    // }
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius - 2)),
        child: NetworkLoadImage(
          url: url,
          image: image,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final String? url;
  final Widget? image;
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final List<BoxShadow>? boxShadow;

  const CircleImage({
    super.key,
    this.url,
    this.image,
    this.borderColor,
    this.size = double.infinity,
    this.borderWidth = 2.0,
    this.padding = EdgeInsets.zero,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: borderColor ?? Colors.white, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: ClipOval(
        child: NetworkLoadImage(
          url: url,
          width: size,
          height: size,
          image: image,
        ),
      ),
    );
  }
}
