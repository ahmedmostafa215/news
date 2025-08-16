import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatelessWidget {
  final News news;
  const NewsBottomSheet({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.01,
        vertical: height*0.01
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: height*0.01),
          if (news.description != null && news.description!.isNotEmpty)
            Text(
              news.description!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor
              ),
            ),
          SizedBox(height: height*0.01),
          SizedBox(
            height: height*0.05,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                launch(news.url??'');
                final uri = Uri.parse(news.url ?? '');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                }
              },
              child: Text(AppLocalizations.of(context)!.view_full_article,
              style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
        ],
      ),
    );
  }
}
