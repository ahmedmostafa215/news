import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/provider/app_language_provider.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  VoidCallback onDrawerClick;
  CustomDrawer({super.key, required this.onDrawerClick});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: AppColors.blackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.news_app,
                style: AppStyles.bold24Black),
              ),
            ),
          ListTile(
            leading: Icon(Icons.home,
              color: AppColors.whiteColor,),
            title: Text(AppLocalizations.of(context)!.go_to_home,
            style: AppStyles.bold20White,),
            onTap: () {
              onDrawerClick();
              Navigator.pop(context);
            },
          ),
          Divider(
            color: AppColors.whiteColor,
            thickness: 1.2,
            indent: width*0.05,
            endIndent: width*0.05,
          ),
          SizedBox(height: height*0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.03
            ),
            child: Row(
              children: [
                Icon(Icons.brush_outlined,
                color: AppColors.whiteColor,),
                SizedBox(width: width*0.02),
                Text(AppLocalizations.of(context)!.theme,
                style: AppStyles.bold20White,)
              ],
            ),
          ),
          SizedBox(height: height*0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.02),
            child: Row(
              children: [
                SizedBox(width: width*0.02),
                Expanded(
                  child: DropdownButton<ThemeMode>(
                    dropdownColor: AppColors.blackColor,
                    value: themeProvider.appTheme,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppLocalizations.of(context)!.dark,
                        style: AppStyles.medium20White,),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(AppLocalizations.of(context)!.light,
                        style: AppStyles.medium20White,),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.changeTheme(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height*0.02),
          Divider(
            color: AppColors.whiteColor,
            thickness: 1.2,
            indent: width*0.05,
            endIndent: width*0.05,
          ),
          SizedBox(height: height*0.02),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.03
            ),
            child: Row(
              children: [
                Icon(Icons.language_outlined,
                  color: AppColors.whiteColor,),
                SizedBox(width: width*0.02),
                Text(AppLocalizations.of(context)!.language,
                  style: AppStyles.bold20White,)
              ],
            ),
          ),
          SizedBox(height: height*0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.02),
            child: Row(
              children: [
                SizedBox(width: width*0.02),
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: AppColors.blackColor,
                    value: languageProvider.appLanguage,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(AppLocalizations.of(context)!.english,
                        style: AppStyles.medium20White,),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(AppLocalizations.of(context)!.arabic,
                        style: AppStyles.medium20White,),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        languageProvider.changeLanguage(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
