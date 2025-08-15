import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/provider/app_language_provider.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_assets.dart';
import 'package:provider/provider.dart';

class Category{
  String id;
  String title;
  String image;

  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoryList(BuildContext context){
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.appTheme == ThemeMode.dark;
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final isArabic = languageProvider.appLanguage == 'ar';
    return[
      Category(
          id: 'general',
          title: AppLocalizations.of(context)!.general,
          image: isDark
            ? (isArabic ? AppAssets.generalArabic : AppAssets.general)
            : (isArabic ? AppAssets.generalDarkArabic : AppAssets.generalDark),
      ),
      Category(
          id: 'business',
          title: AppLocalizations.of(context)!.business,
          image: isDark
              ? (isArabic ? AppAssets.businessArabic : AppAssets.business)
              : (isArabic ? AppAssets.businessDarkArabic : AppAssets.businessDark),
      ),
      Category(
        id: 'sports',
        title: AppLocalizations.of(context)!.sports,
        image: isDark
            ? (isArabic ? AppAssets.sportsArabic : AppAssets.sports)
            : (isArabic ? AppAssets.sportsDarkArabic : AppAssets.sportsDark),
      ),
      Category(
          id: 'health',
          title: AppLocalizations.of(context)!.health,
          image: isDark
              ? (isArabic ? AppAssets.healthArabic : AppAssets.health)
              : (isArabic ? AppAssets.healthDarkArabic : AppAssets.healthDark),
      ),
      Category(
        id: 'entertainment',
        title: AppLocalizations.of(context)!.entertainment,
        image: isDark
            ? (isArabic ? AppAssets.entertainmentArabic : AppAssets.entertainment)
            : (isArabic ? AppAssets.entertainmentDarkArabic : AppAssets.entertainmentDark),
      ),
      Category(
          id: 'technology',
          title: AppLocalizations.of(context)!.technology,
          image: isDark
              ? (isArabic ? AppAssets.technologyArabic : AppAssets.technology)
              : (isArabic ? AppAssets.technologyDarkArabic : AppAssets.technologyDark),
      ),
      Category(
        id: 'science',
        title: AppLocalizations.of(context)!.science,
        image: isDark
            ? (isArabic ? AppAssets.scienceArabic : AppAssets.science)
            : (isArabic ? AppAssets.scienceDarkArabic : AppAssets.scienceDark),
      ),

    ];
  }
}