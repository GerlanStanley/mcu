import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../domain/entities/entities.dart';

import '../../../widgets/widgets.dart';

class ListMoviesItemComponent extends StatelessWidget {
  final MovieEntity movie;
  final MovieEntity? selectedMovie;
  final double imageHeight;
  final Function() onTap;

  const ListMoviesItemComponent({
    Key? key,
    required this.movie,
    required this.selectedMovie,
    required this.imageHeight,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: movie == selectedMovie
                    ? ColorsConstants.primaryDark
                    : ColorsConstants.divider,
                width: 2,
              ),
            ),
            child: CachedNetworkImageWidget(
              image: ApiConstants.imageUrlPrefix + movie.posterPath,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              movie.title,
              maxLines: 2,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              "(${movie.releaseDate.year})",
              maxLines: 2,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .caption!
                    .color!
                    .withOpacity(0.5),
                fontSize: Theme.of(context).textTheme.caption!.fontSize!,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
