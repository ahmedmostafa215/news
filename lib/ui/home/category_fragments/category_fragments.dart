import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/ui/home/category_fragments/category_item.dart';

typedef OnCategoryClick = void Function(Category);
class CategoryFragments extends StatefulWidget {
  OnCategoryClick onCategoryClick;
  CategoryFragments({super.key, required this.onCategoryClick});

  @override
  State<CategoryFragments> createState() => _CategoryFragmentsState();
}

class _CategoryFragmentsState extends State<CategoryFragments> {
  List<Category> categoriesList =[];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    categoriesList = Category.getCategoryList(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.03,
        vertical: height*0.02
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.good_morning,
            style: Theme.of(context).textTheme.headlineMedium,),
          Text(AppLocalizations.of(context)!.here_is_some_news_for_you,
            style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: height*0.02,),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //todo : show category details
                        widget.onCategoryClick(categoriesList[index]);
                      },
                        child: CategoryItem(category: categoriesList[index], index: index));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.02,);
                  },
                  itemCount: categoriesList.length)
          )
        ],
      ),
    );
  }
}
