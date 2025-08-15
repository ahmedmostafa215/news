import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/provider/app_language_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;
  CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<AppLanguageProvider>(context).appLanguage == 'ar';
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool showArrowForward =
        (!isArabic && index % 2 == 0) || (isArabic && index % 2 != 0);
    return Stack(
      alignment: (index%2 == 0)? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
              category.image,
              fit: BoxFit.fill,
              width: double.infinity,
          ),
        ),
        Container(
          width: isArabic ? width * 0.46 : width * 0.41,
          margin: EdgeInsets.symmetric(
            horizontal: width*0.04,
            vertical: height*0.02
          ),
          padding: EdgeInsetsDirectional.only(
            start: (index%2==0) ? width*0.02:0,
            end: (index%2==0) ? 0 : width*0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(84),
            color: AppColors.greyColor
          ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: isArabic
                    ? (index % 2 == 0 ? TextDirection.rtl : TextDirection.ltr)
                    : (index % 2 == 0 ? TextDirection.ltr : TextDirection.rtl),
              children: [
                Text(
                  AppLocalizations.of(context)!.view_all,
                  style: Theme.of(context).textTheme.headlineMedium,),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: (index%2==0) ?
                    Icon(Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).iconTheme.color,)
                      :
                    Icon(Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).iconTheme.color,),
                )
              ],
            ),
          ),
      ],
    );
  }
}
