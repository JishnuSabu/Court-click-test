import 'package:cached_network_image/cached_network_image.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:court_click_task/widgets/loader_widget.dart';
import 'package:flutter/material.dart';

class CustomMovieImage extends StatelessWidget {
  final dynamic movie;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final bool isCircle;

  const CustomMovieImage({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        (movie.posterUrl != null && movie.posterUrl.isNotEmpty)
            ? movie.posterUrl
            : (movie.backdropUrl ?? '');

    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, url) => LoaderWidget(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
      ),
      errorWidget: (_, url, error) => Container(
        color: AppColors.darkCard,
        child: const Icon(Icons.movie, color: Colors.grey),
      ),
    );

    if (isCircle) {
      return ClipOval(child: imageWidget);
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
