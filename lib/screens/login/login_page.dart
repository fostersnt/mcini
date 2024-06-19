import 'package:flutter/material.dart';
import 'package:mcini/data/model/subscriber_model.dart';
import 'package:mcini/screens/home/custom_navigation_bar.dart';
import 'package:mcini/utilities/app_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Image.asset(
                  'lib/assets/images/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: flag
                          ? Container(
                              child: CircularProgressIndicator(
                                color: AppColors.blueColor,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: deviceSize.width * 0.08,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: AppColors.whiteColor),
                        decoration: InputDecoration(
                          fillColor: AppColors.txtFieldBgColor,
                          filled: true,
                          // labelText: 'Phone Number',
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(color: AppColors.whiteColor),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.blueColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.blueColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.blueColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: deviceSize.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.blueColor, // Button background color
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // No rounded corners
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            flag = true;
                          });
                          String msisdn = phoneNumberController.text.trim();
                          final data =
                              await SubscriberModel.getSubscriber(msisdn);
                          print(data);
                          setState(() {
                            flag = false;
                          });
                          if (data['response_status'] == 'success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomNavigationBar(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              AppColors.customSnackBar(
                                  data['response_message'], deviceSize, true),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: deviceSize.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
