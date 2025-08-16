import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/ui/home/category_details/news/news_item.dart';
import 'package:news/utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<News> articles = [];
  int page = 1;
  bool loading = false;
  bool hasMore = true; // عشان نعرف لو لسه فيه أخبار ولا خلصت

  Future<void> fetchNews({bool refresh = false}) async {
    if (loading) return;

    setState(() => loading = true);

    try {
      if (refresh) {
        page = 1;
        articles.clear();
        hasMore = true;
      }

      final response = await ApiManager.getNewsBySourceId(
        sourceId: widget.source.id,
        page: page,
        pageSize: 20,
      );

      if (response.articles?.isEmpty ?? true) {
        hasMore = false;
      } else {
        articles.addAll(response.articles ?? []);
        page++;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.something_went_wrong)),
      );
    }

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty && loading) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).indicatorColor,
        ),
      );
    }

    if (articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.something_went_wrong,
                style: Theme.of(context).textTheme.labelMedium),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greyColor,
              ),
              onPressed: () => fetchNews(refresh: true),
              child: Text(
                AppLocalizations.of(context)!.try_again,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => fetchNews(refresh: true),
      child: ListView.builder(
        itemCount: articles.length + 1,
        itemBuilder: (context, index) {
          if (index < articles.length) {
            return NewsItem(news: articles[index]);
          } else {
            if (!hasMore) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparentColor
                ),
                onPressed: loading ? null : fetchNews,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(AppLocalizations.of(context)!.load_more,
                    style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
