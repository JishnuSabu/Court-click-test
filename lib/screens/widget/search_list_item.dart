import 'package:cached_network_image/cached_network_image.dart';
import 'package:court_click_task/models/trending_movies_model.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchListItem extends StatelessWidget {
  final Results movie;

  const SearchListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: AppColors.lightGrey,
        margin: const EdgeInsets.only(bottom: 3),
        child: Row(
          children: [
            SizedBox(
              width: 146,
              height: 76,
              child: CachedNetworkImage(
                imageUrl: movie.backdropUrl.isNotEmpty
                    ? movie.backdropUrl
                    : movie.posterUrl,
                fit: BoxFit.fill,
                errorWidget: (_, url, error) =>
                    Container(color: AppColors.darkCard),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                movie.displayTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.play_circle_outline,
                size: 32,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
