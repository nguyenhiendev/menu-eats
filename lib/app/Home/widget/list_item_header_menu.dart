import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_eats/app/Home/widget/get_box_offset.dart';
import 'package:uber_eats/app/controller/menu_controller.dart';

class ListItemHeaderMenu extends StatelessWidget {
  const ListItemHeaderMenu({Key? key, required this.controller})
      : super(key: key);
  final MenuScrollController controller;

  @override
  Widget build(BuildContext context) {
    final itemsOffsets = controller.listOffsetItemHeader;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: ((notification) => true),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              right: size.width -
                  (itemsOffsets[itemsOffsets.length - 1] -
                      itemsOffsets[itemsOffsets.length - 2])),
          controller: controller.scrollControllerItemHeader,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: GetX<MenuScrollController>(builder: (controller) {
            return Row(
              children: List.generate(
                controller.listCategory.length,
                (index) {
                  return GetBoxOffset(
                    offset: ((offset) {
                      itemsOffsets[index] = offset.dx;
                    }),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == controller.headerNotifier.value.index
                            ? Colors.black
                            : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        controller.listCategory[index].category,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color:
                                index == controller.headerNotifier.value.index
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
