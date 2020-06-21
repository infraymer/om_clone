import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/screens/base_screen.dart';
import 'package:tinder/utils/auth_firebase.dart';
import 'package:tinder/widgets/app_back_button.dart';
import 'package:tinder/widgets/app_button.dart';
import 'package:tinder/widgets/country_code_widget/country_code_picker.dart';
import 'package:tinder/widgets/custom_app_bar_1.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  final fieldDecoration = BoxDecoration(
    color: AppColors.textField,
    borderRadius: BorderRadius.circular(4),
  );

  final _keyScaffold = GlobalKey<ScaffoldState>();

  CountryCode _countryCode;
  TextEditingController _phoneController = TextEditingController();
  String _platformVersion;

  AuthPhoneFirebase _authPhone;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      keyScaffold: _keyScaffold,
      appBar: CustomAppBar1(
        textTitle: Strings.phoneTitle,
        leading: AppBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(child: _buildTitle()),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                _buildCountryField(),
                SizedBox(width: 16),
                _buildPhoneField(),
              ],
            ),
            SizedBox(height: 24),
            _buildDescription(),
            SizedBox(height: 32),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      Strings.phoneEnterYourMobile,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildCountryField() {
    return Container(
      decoration: fieldDecoration,
      child: Row(
        children: <Widget>[
          CountryCodePicker(
            onChanged: (value) => _countryCode = value,
            onInit: (value) => _countryCode = value,
            textStyle: style,

            initialSelection: _platformVersion ?? 'US',
            flagWidth: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: fieldDecoration,
        child: TextField(
          autofocus: true,
          controller: _phoneController,
          style: style,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
          ],
          decoration: InputDecoration(border: InputBorder.none),
          onSubmitted: (value) {
            _onNext();
          },
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      Strings.phoneDescription,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _authPhone?.isLoadingNotifier ?? ValueNotifier(false),
      builder: (context, loading, child) {
        if (loading)
          return Center(child: CircularProgressIndicator());

        return Container(
          width: double.infinity,
          child: AppButton(
            text: Strings.next,
            onPressed: _onNext,
          ),
        );
      },
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterSimCountryCode.simCountryCode;
    } on PlatformException {
      platformVersion = null;
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _onNext() {
    _authPhone = AuthPhoneFirebase(
      onSendCode: () {
        Navigator.push(context, CodeRoute(_authPhone));
      },
      onAuthenticationSuccessful: (FirebaseAuth firebaseInstance, user) {
        firebaseInstance.currentUser().then((currentUser) {
          String uid = currentUser.uid;
          currentUser.getIdToken().then((token) async {
            //save token and switch to another screen
            Navigator.pushReplacement(context, RegistrationRoute());
          });
        });
      },
      context: context,
      keyScaffold: _keyScaffold,
      phoneNumber: _countryCode.dialCode + _phoneController.text,
    );
    setState(() {});
  }
}
