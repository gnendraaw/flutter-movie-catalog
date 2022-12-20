import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchTvOnAir()
      ..fetchPopularTvs()
      ..fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: kRichBlack),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  WATCHLIST_MOVIE_ROUTE,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('TV Watchlist'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  WATCHLIST_TV_ROUTE,
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ABOUT_ROUTE,
                );
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                TV_SEARCH_ROUTE,
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On Air',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ON_AIR_TV_ROUTE,
                  );
                },
              ),
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.onAirState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.tvOnAir);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    POPULAR_TVS_ROUTE,
                  );
                },
              ),
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.popularTvsState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.popularTvs);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TOP_RATED_TVS_ROUTE,
                  );
                },
              ),
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.topRatedState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.topRatedTvs);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
