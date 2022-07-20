import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:note/app/data/color.dart';
import 'package:note/app/modules/create/views/create_view.dart';
import 'package:note/app/modules/profile/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get uid => _auth.currentUser!.uid;
  get name => _auth.currentUser!.displayName;
  get image => _auth.currentUser!.photoURL;
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection("dataNotes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
          backgroundColor: colorBackground,
          elevation: 0,
          toolbarHeight: 80,
          titleSpacing: 23,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 23),
              child: IconButton(
                onPressed: () => Get.to(() => ProfileView()),
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 21,
                ),
                splashColor: Color(0xFFDED5CA),
                padding: EdgeInsets.all(0),
                splashRadius: 27,
              ),
            )
          ],
          title: Text(
            "Notely.",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: colorText,
            ),
          )),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _notes.where('uid', isEqualTo: uid).snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null || snapshot.data!.docs.length == 0) {
                return SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 60),
                            child: SvgPicture.asset(
                              "assets/images/home.svg",
                              width: 270,
                            ),
                          ),
                          Text(
                            "Create Your First Note",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Remember everything important. A central place for your notes, ideas, lists and reminders.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container(
                width: Get.width,
                padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MasonryGridView.count(
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 7,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Color(0xFFFFF8EE),
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.to(
                                () => CreateView(),
                                arguments: [
                                  snapshot.data!.docs[index]['title'],
                                  snapshot.data!.docs[index]['desc'],
                                  snapshot.data!.docs[index].id,
                                  true
                                ],
                              );
                            },
                            onLongPress: () {
                              Get.dialog(
                                AlertDialog(
                                  backgroundColor: colorBackground,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    "Confirm Delete",
                                    style: TextStyle(
                                      color: colorText,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete this note?",
                                    style: TextStyle(
                                      color: colorText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: colorText,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: colorText,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      onPressed: () {
                                        _notes
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Card(
                              color: Color(0xFFFFF8EE),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['title'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF595550),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['desc'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF595550),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: LinearProgressIndicator(
                    backgroundColor: colorButon,
                    color: colorBackground,
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => CreateView(),
            arguments: [null, null, null, false],
          );
        },
        child: SvgPicture.asset("assets/images/icon_add.svg"),
        backgroundColor: colorButon,
      ),
    );
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: colorText.withOpacity(.6),
        width: 2,
      ),
    );
  }
}
