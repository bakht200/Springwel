import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:springwel/config.dart';
import 'package:springwel/controller/product_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  final String productName;
  var image;
  int price;
  var variants;
  String description;
  ProductDetailScreen(
      {required this.id,
      required this.productName,
      this.image,
      required this.price,
      this.variants,
      required this.description});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<String> items = [
    '0',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
  ];
  String? selectedValue;
  String? selectVariants;
  List<String> variants = [];

  var newPrice = 0.0;

  double? originalPrice;
  double? discount;
  int _n = 1;

  @override
  void initState() {
    super.initState();
    variants = widget.variants.first.options;
    originalPrice = (widget.price).toDouble();
    print(widget.description);
  }

  void _calculateDiscount(discount) {
    setState(() {
      newPrice = originalPrice! - (originalPrice! * discount!);
    });
    print(newPrice);
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.navigate_before,
              size: 30,
              color: PRIMARY_COLOR,
            ),
          ),
          elevation: 0,
          title: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "${widget.productName}",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              height: 250.h,
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.image.length,
                      itemBuilder: (_, index) {
                        return Image.network(
                          "${widget.image[index].src}",
                          width: 350.w,
                        );
                      })
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Column(
                children: [
                  widget.description == ''
                      ? Text(
                          'No Description',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              height: 1.5),
                        )
                      : Text(
                          "${widget.description}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              height: 1.5),
                        ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          child: SizedBox.fromSize(
                            size: Size(26.w, 26.h),
                            child: Material(
                              color: Colors.grey[100],
                              child: GestureDetector(
                                onTap: () async {
                                  minus();
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 25.sp,
                                  color: PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        SizedBox(
                            width: 30.w,
                            child:
                                Text('$_n', style: TextStyle(fontSize: 22.sp))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Card(
                          child: SizedBox.fromSize(
                            size: Size(26.w, 26.h),
                            child: Material(
                              color: Colors.grey[100],
                              child: GestureDetector(
                                onTap: () async {
                                  add();
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 25.sp,
                                  color: PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Variants',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Select variants',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: variants
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  "${item} \$",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: PRIMARY_COLOR,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectVariants,
                      onChanged: (value) {
                        setState(() {
                          selectVariants = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: PRIMARY_COLOR,
                      iconDisabledColor: PRIMARY_COLOR,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Select discount',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  "${item} \$",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: PRIMARY_COLOR,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;

                          _calculateDiscount(
                              double.parse(selectedValue!) / 100);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: PRIMARY_COLOR,
                      iconDisabledColor: PRIMARY_COLOR,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    newPrice == 0.0
                        ? "${widget.price} \$"
                        : "${newPrice.toString()} \$",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: PRIMARY_COLOR),
                  )
                ],
              ),
            )
          ],
        )));
  }
}
