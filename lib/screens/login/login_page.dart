import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                decoration: InputDecoration(
                  fillColor: AppColors.txtFieldBgColor,
                  filled: true,
                  // labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
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
                      borderRadius:
                          BorderRadius.circular(5), // No rounded corners
                    ),
                  ),
                ),
                onPressed: () => {},
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
      ),
    );
  }
}
