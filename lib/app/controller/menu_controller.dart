import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uber_eats/app/data/data.dart';
import 'package:get/get.dart';
import 'package:uber_eats/app/model/my_header.dart';
import 'package:uber_eats/app/model/product_category.dart';

class MenuScrollController extends GetxController {
  // List of product
  late List<ProductCategory> listCategory;
  // Value of offset
  late List<double> listOffsetItemHeader = [];
  // Header notifier
  var headerNotifier = MyHeader().obs;
  // Offset global key
  var golbalOffsetValue = 0.0.obs;
  // Inficator if going down or up in the application
  var goingDown = false.obs;
  // Value to do the validations of the top icons
  var valueScroll = ValueNotifier<double>(0);
  // To have overall control of scrolling
  late ScrollController scrollControllerGlobally;
  // To move top items in menu
  late ScrollController scrollControllerItemHeader;
  // Value indicate if the header is visible
  RxBool visibleHeader = false.obs;

  void loadData() {
    var productsOne = [...products.getRange(0, 3)];
    var prodectsTwo = [...products.getRange(3, 5)];
    var prodectsThree = [...products.getRange(6, 10)];
    var prodectsFour = [...products.getRange(11, 16)];

    listCategory = [
      ProductCategory(category: 'Most Popular', products: []),
      ProductCategory(category: 'Lunch Combinations', products: productsOne),
      ProductCategory(category: 'Sandwiches', products: prodectsTwo),
      ProductCategory(category: 'Main Courses', products: prodectsThree),
      ProductCategory(category: 'Desserts', products: prodectsFour)
    ];
  }

  @override
  void onInit() {
    loadData();
    listOffsetItemHeader =
        List.generate(listCategory.length, (index) => index.toDouble());
    // Get value of index in double catecories
    scrollControllerGlobally = ScrollController();
    // Scroll controller for all page
    scrollControllerItemHeader = ScrollController();

    scrollControllerGlobally.addListener(_listenToScrollChange);
    headerNotifier.listen((value) {
      listenHeaderNotifier();
    });
    visibleHeader.listen((vlue) {
      listVisibleHeader();
    });

    super.onInit();
  }

  // Check if user scroll down or up
  void _listenToScrollChange() {
    golbalOffsetValue.value = scrollControllerGlobally.offset;
    if (scrollControllerGlobally.position.userScrollDirection ==
        ScrollDirection.reverse) {
      goingDown.value = true;
    } else {
      goingDown.value = false;
    }
  }

  // Check if the header is visible of not, if the header is not
  listVisibleHeader() {
    if (visibleHeader.value) {
      headerNotifier.value = MyHeader(index: 0, visible: false);
      return headerNotifier.value;
    }
  }

  // If index of category item = the index of the header and the header visibility is true  make scroll to that index wit animation
  listenHeaderNotifier() {
    if (visibleHeader.value == true) {
      for (var i = 0; i < listCategory.length; i++) {
        if (headerNotifier.value.index == i &&
            headerNotifier.value.visible == true) {
          return scrollAnimationHorizontal(index: i);
        }
      }
    }
  }

  //If the index of the header and the value is visible make an scroll animation that header index
  void scrollAnimationHorizontal({required int index}) {
    if (headerNotifier.value.index == index &&
        headerNotifier.value.visible == true) {
      scrollControllerItemHeader.animateTo(
          listOffsetItemHeader[headerNotifier.value.index!] - 16,
          duration: const Duration(milliseconds: 500),
          curve: goingDown.value ? Curves.easeOut : Curves.fastOutSlowIn);
    }
  }

  void refreshHeader(
    int index,
    bool visible, {
    int? lastIndex,
  }) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue.index;
    final headerVisible = headerValue.visible;
    if (headerTitle != index || lastIndex != null || headerVisible != visible) {
      Future.microtask(() {
        if (!visible && lastIndex != null) {
          headerNotifier.value = MyHeader(visible: true, index: lastIndex);
        } else {
          headerNotifier.value = MyHeader(visible: visible, index: index);
        }
      });
    }
  }

  @override
  void dispose() {
    scrollControllerItemHeader.dispose();
    scrollControllerGlobally.dispose();
    super.dispose();
  }
}
