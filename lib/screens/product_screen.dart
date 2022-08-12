import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:springwel/config.dart';
import 'package:springwel/controller/product_controller.dart';
import 'package:springwel/screens/product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  ProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductProvider productProvider = ProductProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Products',
          style: TextStyle(color: PRIMARY_COLOR, fontSize: 26.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: Builder(builder: (context) {
            final model = Provider.of<ProductProvider>(context);

            if (model.homestate == HomeState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (model.homestate == HomeState.error) {
              return const Center(
                child: Text('An Error Occured'),
              );
            }
            final users = model.productList;
            var response = users
                .where((element) => element.categories!.first.id == widget.id);

            return response.length != 0
                ? GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(users.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => ProductDetailScreen(
                                  id: users[index].id!,
                                  productName: users[index].name!,
                                  image: users[index].images,
                                  price: int.parse(users[index].price!),
                                  variants: users[index].attributes,
                                  description: users[index].description!)));
                        },
                        child: Card(
                          shadowColor: PRIMARY_COLOR,
                          elevation: 5.0,
                          margin: EdgeInsets.all(7.0.w),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 7.0.h),
                                child: Image.network(
                                    users[index].images!.first.src == null
                                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'
                                        : "${users[index].images!.first.src}",
                                    height: 100.h,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(users[index].name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      );
                    }))
                : Center(
                    child: Column(
                    children: [
                      Image.network(
                          "https://static.vecteezy.com/system/resources/previews/004/968/590/non_2x/no-result-data-not-found-concept-illustration-flat-design-eps10-simple-and-modern-graphic-element-for-landing-page-empty-state-ui-infographic-etc-vector.jpg"),
                      SizedBox(
                        child: Text('No Products'),
                      ),
                    ],
                  ));
            ;
          }),
        ),
      ),
    );
  }
}
