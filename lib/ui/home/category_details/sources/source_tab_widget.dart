import 'package:flutter/material.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/ui/home/category_details/news/news_widget.dart';
import 'package:news/ui/home/category_details/sources/source_name.dart';
import 'package:news/utils/app_colors.dart';

class SourceTabWidget extends StatefulWidget {
  List<Source> sourcesList;

  SourceTabWidget({super.key, required this.sourcesList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              dividerColor: AppColors.transparentColor,
              indicatorColor: Theme.of(context).indicatorColor,
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });
              },
              tabs: widget.sourcesList.map((source) {
                return SourceName(
                  source: source,
                  isSelected: selectedIndex == widget.sourcesList.indexOf(source),);
              },).toList(),
            ),
            Expanded(child: NewsWidget(source: widget.sourcesList[selectedIndex])),
          ],
        )
    );
  }
}
