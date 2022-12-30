import 'package:flutter/material.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/dashboard/explore_more_goals.dart';
import 'package:sis_progress/widgets/bottom_nav_bar.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';

class ScaffoldHome extends StatefulWidget {
  const ScaffoldHome({super.key});

  @override
  State<StatefulWidget> createState() => _ScaffoldHome();

}

class _ScaffoldHome extends State<ScaffoldHome> {
  int _selected = 0;

  Future<bool> _onBackButtonPressed() {
    setState(() {
      _selected = 0;
    });

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: NavBar(selected: _selected, onChange: (int count) {
          setState(() {
            _selected = count;
          });
        }),
        appBar: CustomAppBar(buildLogoIcon(), List.empty()),
        body: getPage(pageIndex: _selected),
      ),
    );
  }
  
}

Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}


Widget getPage({required int pageIndex}) {
  if(pageIndex == 0) {
    return const Dashboard(fullName: "Montana");
  }

  return const ExploreMoreGoals();
}