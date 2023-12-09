import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/controllers/new_record/new_record_controller.dart';
import 'package:avi/utils/app_colors.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:path/path.dart' as Path1;
import '../../widgets/form_input_with_hint_on_top.dart';
import '../../widgets/rounded_edged_button.dart';

class NewRecordPage extends StatefulWidget {
  final String projectId;

  final String clientId;

  NewRecordPage({Key? key, required this.projectId, required this.clientId})
      : super(key: key);

  @override
  State<NewRecordPage> createState() => _NewRecordPageState();
}

class _NewRecordPageState extends State<NewRecordPage> with BaseClass {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  NewRecordController newRecordController = Get.put(NewRecordController());

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timer.tick.seconds.inSeconds % 10 == 0) {
          newRecordController.updateRecordTime();
          _handleClickCapture(CaptureMode.screen);
          print("NEW PICTURE");
        }
      },
    );
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  void addImageToFirebase({required String imgPath}) async {
    try {
      final File file = File(imgPath);
      String baseName = Path1.basename(imgPath);
      Reference storagerefrence = storage.ref().child('card_images/$baseName');
      print(storagerefrence);
      TaskSnapshot uploadTask = await storagerefrence.putFile(file);
      print(uploadTask);
      String url = await storagerefrence
          .getDownloadURL(); //download url from firestore and add to firebase database
      await recordController.uploadScreenCapturedScreeShots(
        url,
        widget.projectId,
        recordController.recordId,
      );
      print(url);
    } catch (e) {
      print(e.toString());
    }
    //reference.child("image").push().set({'image': url});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  bool _isAccessAllowed = false;

  CapturedData? _lastCapturedData;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _isAccessAllowed = await ScreenCapturer.instance.isAccessAllowed();
    print("INIT");
    print(_isAccessAllowed);
  }

  void _handleClickCapture(CaptureMode mode) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName =
        'Screenshot-${DateTime.now().millisecondsSinceEpoch}.png';
    String imagePath =
        '${directory.path}/screen_capturer_example/Screenshots/$imageName';
    _lastCapturedData = await ScreenCapturer.instance.capture(
      mode: mode,
      imagePath: imagePath,
      silent: true,
    );
    if (_lastCapturedData != null) {
      print("upload");
      addImageToFirebase(imgPath: imagePath);
    } else {
      // ignore: avoid_print
      print('User canceled capture');
    }
    setState(() {});
  }

  NewRecordController recordController = Get.put(NewRecordController());

  Future<bool> exitConfirm() async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              content: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Stop Timer",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Going back will stop the timer",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            popToPreviousScreen(context: context);
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              showCircularDialog(context);
                              await recordController.updateArray(
                                  endTime: DateTime.now().toString());

                              timer?.cancel();
                              recordController.recordId = "";
                              if (mounted) {
                                popToPreviousScreen(context: context);
                                popToPreviousScreen(context: context);
                                popToPreviousScreen(context: context);
                                popToPreviousScreen(context: context);
                              }
                            } catch (e) {
                              if (mounted) {
                                popToPreviousScreen(context: context);
                              }
                              showError(title: "Error", message: e.toString());
                            }
                          },
                          child: const Text(
                            "Confirm",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Record",
            style: GoogleFonts.poppins(color: AppColors.primaryColor),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<NewRecordController>(
            init: recordController,
            builder: (snapshot) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          bool allowed =
                              await ScreenCapturer.instance.isAccessAllowed();
                          if (allowed) {
                            if (kDebugMode) {
                              print("ALLOWED");
                            }
                            setState(() {
                              _isAccessAllowed = allowed;
                            });
                            if (timer != null) {
                              if (timer!.isActive) {
                                exitConfirm();
                                /*      timer?.cancel();
                                _lastCapturedData == null;
                                _lastCapturedData?.imagePath == null;
                                setState(() {});*/
                              } else {
                                print("TIMER NOT ACTIVE");
                              }
                            } else {}
                          } else {
                            print("NOT ALLOWED");
                            await ScreenCapturer.instance.requestAccess();
                          }
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: Center(
                            child: Text(
                              "Start/Stop",
                              style:
                                  GoogleFonts.poppins(color: AppColors.bgWhite),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${snapshot.recordTimeOnScreen} hrs",
                        style:
                            GoogleFonts.poppins(color: AppColors.primaryColor),
                      ),
                      (_lastCapturedData != null &&
                              _lastCapturedData?.imagePath != null)
                          ? timer?.isActive ?? false
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: 400,
                                  height: 250,
                                  child: Image.file(
                                    File(_lastCapturedData!.imagePath!),
                                  ),
                                )
                              : Container()
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      timer?.isActive ?? false
                          ? Container()
                          : FormInputWithHint(
                              label: 'Name',
                              hintText: 'Enter Name',
                              controller: nameController,
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      timer?.isActive ?? false
                          ? Container()
                          : FormInputWithHint(
                              maxLine: 5,
                              label: 'Comments',
                              controller: commentController,
                              hintText: 'Add Comment',
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      timer?.isActive ?? false
                          ? Container()
                          : Row(
                              children: [
                                Expanded(
                                  child: RoundedEdgedButton(
                                    buttonText: "Cancel",
                                    buttonBackground: Colors.white,
                                    buttonTextColor: Colors.black,
                                    onButtonClick: () {
                                      popToPreviousScreen(context: context);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: RoundedEdgedButton(
                                    buttonText: "Submit",
                                    onButtonClick: () async {
                                      String name = nameController.text.trim();
                                      String comment =
                                          commentController.text.trim();
                                      if (name.isEmpty) {
                                        showError(
                                            title: "Name",
                                            message: "Please add record Name");
                                      } else if (comment.isEmpty) {
                                        showError(
                                            title: "Comment",
                                            message:
                                                "Please add record Comment");
                                      } else {
                                        try {
                                          bool allowed = await ScreenCapturer
                                              .instance
                                              .isAccessAllowed();
                                          if (!allowed) {
                                            showError(
                                                title: "NEED ACCESS",
                                                message:
                                                    "We need access to capture screen to track the activity");
                                            await ScreenCapturer.instance
                                                .requestAccess();
                                            return;
                                          }
                                          showCircularDialog(context);
                                          await newRecordController
                                              .addNewRecord(
                                            name: name,
                                            comment: comment,
                                            projectId: widget.projectId,
                                            clientId: widget.clientId,
                                          );
                                          popToPreviousScreen(context: context);
                                          /*nameController.text = "";
                                          commentController.text = "";*/
                                          startTimer();
                                          setState(() {});
                                          showSuccess(
                                              title: "Timer",
                                              message:
                                                  "New Record added and Timer has Started");
                                        } catch (e) {
                                          popToPreviousScreen(context: context);
                                          showError(
                                              title: "Error",
                                              message: e.toString());
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
