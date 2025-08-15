import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/ui/home/category_details/news/news_item.dart';
import 'package:news/utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(widget.source.id?? ''),
      builder: (context, snapshot){
        //todo : loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).indicatorColor,
            ),
          );
        }
        //todo : client error
        else if (snapshot.hasError){
          return Center(
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.something_went_wrong,
                  style: Theme.of(context).textTheme.labelMedium,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor,
                    ),
                    onPressed: () {
                      ApiManager.getNewsBySourceId(widget.source.id??'');
                      setState(() {

                      });
                    },
                    child: Text(AppLocalizations.of(context)!.try_again,
                      style: Theme.of(context).textTheme.labelSmall,))
              ],
            ),
          );
        }
        //todo : server => response => success , error
        //todo : server error
        if (snapshot.data?.status != 'ok'){
          return Center(
            child: Column(
              children: [
                Text(snapshot.data!.message!,
                  style: Theme.of(context).textTheme.labelMedium,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor,
                    ),
                    onPressed: () {
                      ApiManager.getNewsBySourceId(widget.source.id??'');
                      setState(() {

                      });
                    },
                    child: Text(AppLocalizations.of(context)!.try_again,
                      style: Theme.of(context).textTheme.labelMedium,))
              ],
            ),
          );
        }
        //todo : server success
        var newsList = snapshot.data?.articles??[];
        return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index],);
            },
            itemCount: newsList.length);
      },
    );

  }
}
