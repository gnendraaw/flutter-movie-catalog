import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_status_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetalPageState createState() => _TvDetalPageState();
}

class _TvDetalPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
    context
        .read<TvRecommendationsBloc>()
        .add(FetchTvRecommendations(widget.id));
    context.read<TvWatchlistStatusBloc>().add(LoadWatchlistTvStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            return SafeArea(
              child: DetailContent(
                state.result,
              ),
            );
          } else if (state is TvDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;

  DetailContent(
    this.tv,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tv.name,
                            style: kHeading5,
                          ),
                          BlocBuilder<TvWatchlistStatusBloc,
                              TvWatchlistStatusState>(
                            builder: (context, state) {
                              if (state is TvWatchlistStatusLoaded) {
                                return ElevatedButton(
                                  onPressed: () {
                                    !state.isAddedWatchlist
                                        ? context
                                            .read<TvWatchlistStatusBloc>()
                                            .add(SaveTvWatchlist(tv))
                                        : context
                                            .read<TvWatchlistStatusBloc>()
                                            .add(RemoveTvWatchlist(tv));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              } else if (state is TvWatchlistStatusError) {
                                return Center(
                                  child: Text(state.message),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Text(
                            _showGenres(tv.genres),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: tv.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${tv.voteAverage}'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Overview',
                            style: kHeading6,
                          ),
                          Text(
                            tv.overview,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Recommendations',
                            style: kHeading6,
                          ),
                          BlocBuilder<TvRecommendationsBloc,
                              TvRecommendationsState>(
                            builder: (context, state) {
                              if (state is TvRecommendationsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TvRecommendationsLoaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.result[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TV_DETAIL_ROUTE,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.result.length,
                                  ),
                                );
                              } else if (state is TvRecommendationsError) {
                                return Center(
                                  child: Text(state.message),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: 4,
                      width: 48,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
