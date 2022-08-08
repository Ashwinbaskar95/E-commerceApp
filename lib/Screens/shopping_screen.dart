import 'package:flutter/material.dart';
import 'package:ashwinkart/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ashwinkart/model/productData.dart';
import 'package:ashwinkart/Controllers/productController.dart';
import 'package:ashwinkart/Components/tabData.dart';
import 'package:get/get.dart';
import 'package:ashwinkart/Screens/cart_screen.dart';
import 'package:ashwinkart/Controllers/cartController.dart';
import 'package:provider/provider.dart';

class shoppingScreen extends StatefulWidget {
  static const String id = 'shopping_screen';
  const shoppingScreen({Key? key}) : super(key: key);

  @override
  State<shoppingScreen> createState() => _shoppingScreenState();
}

class _shoppingScreenState extends State<shoppingScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  productController product = productController();
  cartController cartControl = cartController();

  String? username;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        username = auth.currentUser?.displayName;
      }
    } catch (e) {
      print(e);
    }
  }

  List<tabdata> tabitems = [
    tabdata(icon: Icons.phone, category: 'phone'),
    tabdata(icon: Icons.laptop, category: 'laptop'),
    tabdata(icon: Icons.lightbulb, category: 'light'),
    tabdata(icon: Icons.tv, category: 'tv'),
    tabdata(icon: Icons.speaker, category: 'speaker'),
  ];

  final _auth = FirebaseAuth.instance;

  int current = 0;
  String displaycategory = 'phone';

  List<String> categories = ['Phone', 'Laptop', 'Tablet', 'TV', 'Speakers'];

  tabdata tab = tabdata();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text('Hi, User'),
        actions: [
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/default.jpg'),
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomsheet(context)));
                    },
                  ))
            ],
          ),
          IconButton(
              onPressed: () => Get.to(() => cartScreen()),
              icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.teal,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                              displaycategory =
                                  tabitems[index].category.toString();
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(microseconds: 300),
                            margin: EdgeInsets.all(5),
                            width: 80,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: Colors.tealAccent, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Icon(
                                (tabitems[index].icon),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: current == index,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.teal),
                            ))
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: product.readjsondata(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var item = data.data as List<productData>;
                    return Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            scrollDirection: Axis.vertical,
                            controller:
                                ScrollController(keepScrollOffset: true),
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: item == null ? 0 : item.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: (item[index].category == displaycategory)
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          tileColor: Colors.white,
                                          leading: Image(
                                              image: NetworkImage(item[index]
                                                  .imageUrl
                                                  .toString())),
                                          title:
                                              Text(item[index].name.toString()),
                                          subtitle: Text(
                                              item[index].model.toString()),
                                          trailing: Text(
                                              item[index].price.toString()),
                                          onTap: () {
                                            showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 300,
                                                          width: 200,
                                                          child: Image(
                                                              image: NetworkImage(
                                                                  item[index]
                                                                      .imageUrl
                                                                      .toString())),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${item[index].name.toString()}' +
                                                              ' ' +
                                                              '${item[index].model.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Manufactured date :',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                item[index]
                                                                    .manufacturedate
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Manufactured address :',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                item[index]
                                                                    .manufactureaddress
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Product price :',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                item[index]
                                                                    .price
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Add to cart',
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .teal,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Provider.of<cartController>(context, listen: false).addproduct(
                                                                        ImageUrl: item[index]
                                                                            .imageUrl
                                                                            .toString(),
                                                                        Name: item[index]
                                                                            .name
                                                                            .toString(),
                                                                        Model: item[index]
                                                                            .model
                                                                            .toString(),
                                                                        Price: item[index]
                                                                            .price
                                                                            .toString());
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .add)),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : null,
                              );
                            }));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
