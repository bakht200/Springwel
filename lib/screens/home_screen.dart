import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:springwel/config.dart';

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
        actions: [
          const Icon(
            Icons.logout,
            color: Colors.white,
          )
        ],
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
          child: Builder(builder: (context) {
            final model = Provider.of<CategoryProvider>(context);
            print(model.homestate);
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
                  return Card(
                    shadowColor: PRIMARY_COLOR,
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(
                              users[index].image == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'
                                  : "${users[index].image?.src}",
                              height: 140,
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(users[index].name.toString(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  );
                }));
          }),
        ),
      ),
    );
  }
}
