import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/model/category.dart';
import 'package:news/ui/home/category_details/sources/source_tab_widget.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  Category category;
  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(widget.category.id),
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
                        ApiManager.getSources(widget.category.id);
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
                        ApiManager.getSources(widget.category.id);
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
          var sourcesList = snapshot.data?.sources ?? [];
          return SourceTabWidget(sourcesList: sourcesList);
        },
    );
  }
}
