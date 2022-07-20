import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:note/app/data/auth.dart';
import 'package:note/app/data/color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get name => _auth.currentUser!.displayName;
  get image => _auth.currentUser!.photoURL;
  get email => _auth.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorBackground,
        elevation: 0,
        leadingWidth: 58,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset("assets/images/icon_back.svg"),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 40),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                        radius: 60,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton.icon(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: colorBackground,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(
                                  "Confirm Log out",
                                  style: TextStyle(
                                    color: colorText,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                content: Text(
                                  "Are you sure you want to log out? You will be returned to login screen",
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
                                      "Log out",
                                      style: TextStyle(
                                        color: colorText,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    onPressed: () {
                                      AuthService().signOut();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          icon:
                              SvgPicture.asset("assets/images/icon_logout.svg"),
                          label: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: colorText,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: colorBackground,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
