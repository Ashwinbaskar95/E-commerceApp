import 'package:flutter/material.dart';
import 'package:ashwinkart/Controllers/cartController.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class cartScreen extends StatefulWidget {
  static const String id = 'cartScreen';

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  cartController controller = Get.put(cartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Your cart'),
      ),
      body: Container(
        child:
            Consumer<cartController>(builder: (context, cartController, child) {
          return ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  {
                    if (newIndex > oldIndex) {
                      newIndex = newIndex - 1;
                    }
                    final element = controller.cartitem.removeAt(oldIndex);
                    controller.cartitem.insert(newIndex, element);
                  }
                });
              },
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.cartitem.length,
              itemBuilder: (context, int index) {
                final cartlist = controller.cartdatamodel[index];
                return Card(
                  key: ValueKey(cartlist.name),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    leading: Image(
                        image: NetworkImage(cartlist.imageUrl.toString())),
                    title: Text('${cartlist.name.toString()}' +
                        ' ' +
                        '${cartlist.model.toString()}'),
                    trailing: Text(cartlist.price.toString()),
                  ),
                );
              });
        }),
      ),
    );
    ;
  }
}
