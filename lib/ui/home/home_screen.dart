import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/ui/home/category_details/category_details.dart';
import 'package:news/ui/home/category_fragments/category_fragments.dart';
import 'package:news/ui/home/custom_drawer.dart';
import 'package:news/ui/home/news_search.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          selectedCategory?.title ?? AppLocalizations.of(context)!.home,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: NewsSearch(context)
                );
              },
              icon: Icon(Icons.search_rounded)
          )
        ],
      ),
      drawer: Drawer(
        child: CustomDrawer(
            onDrawerClick: onDrawerClick
        ),
      ),
      body: selectedCategory == null ?
          CategoryFragments(onCategoryClick: onCategoryClick ,):
          CategoryDetails(category: selectedCategory!,),
    );
  }

  Category? selectedCategory;

  void onCategoryClick(Category newSelectedCategory){
    selectedCategory = newSelectedCategory;
    setState(() {

    });
  }

  void onDrawerClick(){
    selectedCategory = null;
    setState(() {

    });
  }
}
