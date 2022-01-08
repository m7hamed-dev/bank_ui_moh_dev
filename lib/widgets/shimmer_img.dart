import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImg extends StatelessWidget {
  const ShimmerImg({
    Key? key,
    this.height,
    this.isCircleShape,
    this.width,
  }) : super(key: key);
  //
  final double? width;
  final double? height;
  final bool? isCircleShape;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.yellow,
          shape: isCircleShape == true ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}

class CustomCahchedImg extends StatelessWidget {
  const CustomCahchedImg({
    Key? key,
    this.height,
    this.width,
    this.imageUrl,
    this.isCircleShape,
  }) : super(key: key);
  //
  final double? width;
  final double? height;
  final String? imageUrl;
  final bool? isCircleShape;
  //
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl ??
          'https://www.niemanlab.org/images/Greg-Emerson-edit-2.jpg',
      // imageUrl: Constant.userImageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) => const ShimmerImg(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
