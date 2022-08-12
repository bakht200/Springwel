import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:springwel/config.dart';
import 'package:springwel/main.dart';
import 'package:springwel/screens/product_screen.dart';

import '../controller/categories_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (builder) => Login()),
                  (route) => false);
            },
            child: const Icon(
              Icons.logout,
              color: PRIMARY_COLOR,
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text(
          'Springwel',
          style: TextStyle(color: PRIMARY_COLOR, fontSize: 26.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
          child: Builder(builder: (context) {
            final model = Provider.of<CategoryProvider>(context);

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
            final users = model.categoriesList;
            return GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                physics: PageScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(users.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) =>
                              ProductScreen(id: users[index].id!)));
                    },
                    child: Card(
                      shadowColor: PRIMARY_COLOR,
                      elevation: 5.0,
                      margin: EdgeInsets.all(8.0.sp),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: Image.network(
                                users[index].image == null
                                    ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'
                                    : "${users[index].image?.src}",
                                height: 110.h,
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Text(users[index].name.toString(),
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                }));
          }),
        ),
      ),
    );
  }
}
