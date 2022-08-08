import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

final ImagePicker picker = ImagePicker();
PickedFile? Imagefile;
Widget bottomsheet(context) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: [
        Text(
          'Choose profile pic',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => pickimage(ImageSource.camera),
              icon: Icon(
                Icons.camera,
                size: 50,
              ),
            ),
            SizedBox(width: 20),
            IconButton(
                onPressed: () => pickimage(ImageSource.gallery),
                icon: Icon(
                  Icons.image,
                  size: 50,
                ))
          ],
        )
      ],
    ),
  );
}

File? image;
Future pickimage(ImageSource source) async {
  var image = await ImagePicker().pickImage(source: source);
  final imageTemporary = File(image!.path);
}
