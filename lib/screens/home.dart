import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/components/map_info_sheet.dart';

import 'package:woauto/components/top_header.dart';
import 'package:woauto/utils/utilities.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: getBackgroundColor(context),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: const [
            GMap(),
            TopHeader(),
            MapInfoSheet(),
          ],
        ),
      ),
    );
  }
}
