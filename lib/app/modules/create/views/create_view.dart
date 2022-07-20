import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:note/app/data/color.dart';
import '../controllers/create_controller.dart';

class CreateView extends GetView<CreateController> {
  final _inputTitle = TextEditingController();
  final _inputDesc = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get uid => _auth.currentUser!.uid;
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection("dataNotes");
  final _notesArg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if (_notesArg[3] == true) {
      _inputTitle.text = _notesArg[0].toString();
      _inputDesc.text = _notesArg[1].toString();
    }
    return Scaffold(
      backgroundColor: Color(0xFFF8EEE2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/images/icon_back.svg"),
                    ),
                    ElevatedButton(
                      onPressed: (_notesArg[3] == true)
                          ? () {
                              _notes.doc(_notesArg[2]).update({
                                'title': _inputTitle.text,
                                'desc': _inputDesc.text,
                                'uid': uid,
                              });
                              Get.back();
                            }
                          : () {
                              _notes.add({
                                'title': _inputTitle.text,
                                'desc': _inputDesc.text,
                                'uid': uid,
                              });
                              Get.back();
                            },
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        primary: colorButon,
                        minimumSize: Size(70, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        textStyle: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: colorText3,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 28,
                ),
                TextField(
                  controller: _inputTitle,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: colorText.withOpacity(.6),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: colorText,
                  ),
                ),
                TextField(
                  controller: _inputDesc,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Desc",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorText2.withOpacity(.6),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorText2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
