import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_eats/app/Home/widget/background_menu.dart';
import 'package:uber_eats/app/Home/widget/list_item_header_menu.dart';
import 'package:uber_eats/app/Home/widget/menu_body_items.dart';
import 'package:uber_eats/app/Home/widget/menu_header_data.dart';
import 'package:uber_eats/app/Home/widget/my_header_title.dart';
import 'package:uber_eats/app/controller/menu_controller.dart';

class HomeMenuWithTab extends StatelessWidget {
  HomeMenuWithTab({Key? key}) : super(key: key);
  final controller = Get.put(MenuScrollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Scrollbar(
        radius: const Radius.circular(8),
        notificationPredicate: (scroll) {
          controller.valueScroll.value = scroll.metrics.extentInside;
          return true;
        },
        child: GetX<MenuScrollController>(builder: (controller) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollControllerGlobally,
            slivers: [
              _FlexibleSpaceBarHeader(
                  valueScroll: controller.golbalOffsetValue.value,
                  controller: controller),
              SliverPersistentHeader(
                  pinned: true, delegate: _HeaderMenu(controller: controller)),
              for (var i = 0; i < controller.listCategory.length; i++) ...[
                SliverPersistentHeader(
                  // Widget MyHeaderTitle
                  delegate: MyHeaderTitle(
                    controller.listCategory[i].category,
                    ((visible) => controller.refreshHeader(i, visible,
                        lastIndex: i > 0 ? i - 1 : null)),
                  ),
                ),
                // Widget MenuBodyItems
                MenuBodyItems(
                  listItem: controller.listCategory[i].products,
                ),
              ]
            ],
          );
        }),
      ),
    );
  }
}

class _FlexibleSpaceBarHeader extends StatelessWidget {
  const _FlexibleSpaceBarHeader(
      {Key? key, required this.valueScroll, required this.controller})
      : super(key: key);

  final double valueScroll;
  final MenuScrollController controller;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      expandedHeight: 260,
      pinned: valueScroll < 90 ? true : false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          stretchModes: const [StretchMode.zoomBackground],
          background: Stack(fit: StackFit.expand, children: [
            // Widget BackgroundMenu
            const BackgroundMenu(),
            Positioned(
              right: 10,
              top: (sizeHeight + 20) - controller.valueScroll.value,
              child: Stack(
                children: const [
                  Center(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: (sizeHeight + 20) - controller.valueScroll.value,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

const _maxHeaderExtent = 130.0;

class _HeaderMenu extends SliverPersistentHeaderDelegate {
  _HeaderMenu({required this.controller});
  final MenuScrollController controller;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    if (percent > 0.1) {
      controller.visibleHeader.value = true;
    } else {
      controller.visibleHeader.value = false;
    }
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            height: _maxHeaderExtent,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: percent > 0.1 ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      AnimatedSlide(
                        offset: Offset(percent < 0.1 ? 0.02 : 0.1, 0),
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeIn,
                        child: const Text(
                          "Amerigo Italian Restaurant",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Expanded(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: percent > 0.0
                          ? ListItemHeaderMenu(controller: controller)
                          : const MenuHeaderData()),
                )
              ],
            ),
          ),
        ),
        if (percent > 0.1)
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: percent > 0.1
                      ? Container(
                          height: 0.5,
                          color: Colors.transparent,
                        )
                      : null))
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
