import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/ui/home/category_details/news_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  News news;
  NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).iconTheme.color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => NewsBottomSheet(news: news),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width*0.02,
          vertical: height*0.01
        ),
        padding: EdgeInsets.symmetric(
          vertical: height*0.02,
          horizontal: width*0.02
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).iconTheme.color!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage??'',
                placeholder: (context, url) => Center(child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: height*0.02,),
            Text(news.title??'',
            style: Theme.of(context).textTheme.labelLarge,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.by} : ${news.author ?? ''}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Text(
                  timeago.format(
                    DateTime.parse(news.publishedAt??''),
                    locale: Localizations.localeOf(context).languageCode,
                    allowFromNow: true,
                  ),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
