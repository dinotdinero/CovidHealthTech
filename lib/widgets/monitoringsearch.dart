import 'package:flutter_appcovidhealth2/Home/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonitoringSearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell();

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
