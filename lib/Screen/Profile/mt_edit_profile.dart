import 'dart:io';
import 'package:cash_rocket/Repositories/authentication_repo.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:cash_rocket/Screen/Profile/mt_change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Model/user_profile_model.dart';
import '../../Provider/profile_provider.dart';
import '../Constant Data/constant.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final UserProfileModel user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String profilePicture = 'https://st2.depositphotos.com/2703645/7304/v/600/depositphotos_73040075-stock-illustration-male-avatar-icon.jpg';

  // ignore: prefer_typing_uninitialized_variables
  var dialogContext;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  File imageFile = File('No File');
  String imagePath = 'No Data';

  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    profilePicture = widget.user.data?.user?.image ?? 'https://st2.depositphotos.com/2703645/7304/v/600/depositphotos_73040075-stock-illustration-male-avatar-icon.jpg';
    fullNameController.text = widget.user.data?.user?.name ?? 'Not Defined';
    mobileController.text = widget.user.data?.user?.phone ?? 'Not Defined';
    emailController.text = widget.user.data?.user?.email ?? 'Not Defined';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
        ),
        backgroundColor: kMainColor,
        elevation: 0.0,
        title: Text(
          lang.S.of(context).editProfile,
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Consumer(builder: (_, ref, watch) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            // ignore: sized_box_for_whitespace
                            child: Container(
                              height: 200.0,
                              width: MediaQuery.of(context).size.width - 80,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        pickedImage = await _picker.pickImage(source: ImageSource.gallery);
                                        setState(() {
                                          imageFile = File(pickedImage!.path);
                                          imagePath = pickedImage!.path;
                                        });
                                        Future.delayed(const Duration(milliseconds: 100), () {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.photo_library_rounded,
                                            size: 60.0,
                                            color: kMainColor,
                                          ),
                                          Text(
                                            lang.S.of(context).gallary,
                                            style: GoogleFonts.poppins(
                                              fontSize: 20.0,
                                              color: kMainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        pickedImage = await _picker.pickImage(source: ImageSource.camera);
                                        setState(() {
                                          imageFile = File(pickedImage!.path);
                                          imagePath = pickedImage!.path;
                                        });
                                        Future.delayed(const Duration(milliseconds: 100), () {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera,
                                            size: 60.0,
                                            color: kGreyTextColor,
                                          ),
                                          Text(
                                            lang.S.of(context).camera,
                                            style: GoogleFonts.poppins(
                                              fontSize: 20.0,
                                              color: kGreyTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(120)),
                          image: imagePath == 'No Data'
                              ? DecorationImage(
                                  image: NetworkImage(profilePicture),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(120)),
                            color: kMainColor,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                AppTextField(
                  showCursor: false,
                  textFieldType: TextFieldType.NAME,
                  controller: fullNameController,
                  decoration: kInputDecoration.copyWith(
                    labelText: lang.S.of(context).fullName,
                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                    hintText: lang.S.of(context).enterFullName,
                    hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                ),
                const SizedBox(height: 15.0),
                AppTextField(
                  showCursor: false,
                  textFieldType: TextFieldType.NUMBER,
                  controller: mobileController,
                  decoration: kInputDecoration.copyWith(
                    labelText: lang.S.of(context).mobile,
                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                    hintText: lang.S.of(context).enterYourMobile,
                    hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                ),
                const SizedBox(height: 15.0),
                AppTextField(
                  showCursor: false,
                  textFieldType: TextFieldType.EMAIL,
                  controller: emailController,
                  decoration: kInputDecoration.copyWith(
                    labelText: lang.S.of(context).email,
                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                    hintText: lang.S.of(context).enterYourEmail,
                    hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                ),
                ButtonGlobal(
                  buttontext: lang.S.of(context).saves,
                  buttonDecoration: kButtonDecoration,
                  onPressed: () async {
                    try {
                      EasyLoading.show(status: 'Updating Profile');
                      int size = imageFile != File('No FIle') ? 0 : imageFile.lengthSync();
                      double sizeInMb = size / (1024 * 1024);
                      if (sizeInMb < 2.0) {
                        var response = await AuthRepo().editProfile(fullNameController.text, mobileController.text, emailController.text, imagePath);
                        if (response && mounted) {
                          // ignore: unused_result
                          ref.refresh(personalProfileProvider);
                          const Home().launch(context);
                          EasyLoading.showSuccess('Profile Edited Successfully');
                        } else {
                          EasyLoading.showError('Error Happened. Try again');
                        }
                      } else {
                        EasyLoading.showError('Image size should be smaller than 2 mb');
                      }
                    } catch (e) {
                      EasyLoading.showError(e.toString());
                    }
                  },
                ),
                ButtonGlobal(
                    buttontext: lang.S.of(context).changePassword,
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      const ChangePassword().launch(context);
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
