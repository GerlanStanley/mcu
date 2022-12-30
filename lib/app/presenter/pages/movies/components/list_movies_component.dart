import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class ListMoviesComponent extends StatelessWidget {
  final TabController tabController;

  const ListMoviesComponent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        padding: const EdgeInsets.all(0),
        indicatorColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.all(0),
        indicatorWeight: 0.1,
        tabs: const [
          CachedNetworkImageWidget(
            image:
                "https://image.tmdb.org/t/p/original/xYijVAPunk6neVW2KHKE4Lp45ZU.jpg",
            width: 150,
            fit: BoxFit.cover,
          ),
          CachedNetworkImageWidget(
            image:
                "https://image.tmdb.org/t/p/original/xYijVAPunk6neVW2KHKE4Lp45ZU.jpg",
            width: 150,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
