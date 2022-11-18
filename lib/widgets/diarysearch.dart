import 'package:flutter_appcovidhealth2/Home/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ),
      );
  
  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
