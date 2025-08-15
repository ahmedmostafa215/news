import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/ui/home/category_details/news/news_item.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/l10n/app_localizations.dart';

class NewsSearch extends SearchDelegate {
  final String searchHint;

  NewsSearch(BuildContext context)
      : searchHint = AppLocalizations.of(context)!.search;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.hintColor),
      ),
      textTheme: theme.textTheme,
    );
  }

  @override
  String get searchFieldLabel => searchHint;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.enter_search_term),
      );
    }

    return FutureBuilder<NewsResponse?>(
      future: ApiManager.searchNews(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).iconTheme.color,
            ),
          );
        } else if (snapshot.hasError) {
          return _errorWidget(
              context, AppLocalizations.of(context)!.something_went_wrong);
        }

        if (snapshot.data?.status != 'ok') {
          return _errorWidget(
              context, snapshot.data?.message ?? 'Unknown error');
        }

        final articles = snapshot.data!.articles!;
        if (articles.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)!.no_results));
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final news = articles[index];
            return NewsItem(news: news);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _errorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: Theme.of(context).textTheme.labelMedium),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyColor,
            ),
            onPressed: () => ApiManager.searchNews(query),
            child: Text(AppLocalizations.of(context)!.try_again,
                style: Theme.of(context).textTheme.labelSmall),
          )
        ],
      ),
    );
  }
}
