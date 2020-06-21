import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/screens/base_screen.dart';
import 'package:tinder/utils/auth_firebase.dart';
import 'package:tinder/widgets/app_back_button.dart';
import 'package:tinder/widgets/app_button.dart';
import 'package:tinder/widgets/custom_app_bar_1.dart';
import 'package:tinder/widgets/pincode/models/pin_theme.dart';
import 'package:tinder/widgets/pincode/pin_code_fields_custom.dart';

class CodeScreen extends StatefulWidget {
  final AuthPhoneFirebase authPhone;

  const CodeScreen({Key key, this.authPhone}) : super(key: key);

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  final fieldDecoration = BoxDecoration(
    color: AppColors.textField,
    borderRadius: BorderRadius.circular(4),
  );

  final _keyScaffold = GlobalKey<ScaffoldState>();
  final _codeController = TextEditingController();

  final _showTimer = ValueNotifier<bool>(false);
  final _timerValue = ValueNotifier<int>(0);

  Timer _timer;

  void _initTimer() {
    setState(() {
      _timerValue.value = 60;
      _showTimer.value = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timerValue.value < 1) {
        setState(() {
          _showTimer.value = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _timerValue.value = _timerValue.value - 1;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          children: <Widget>[
            _buildPhone(),
            SizedBox(height: 40),
            _buildCode(),
            SizedBox(height: 32),
            _buildButton(context),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNoCodeButton(),
                _buildTimer(),
              ],
            ),
            SizedBox(height: 20),
            // _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      Strings.welcomeDescription,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.authPhone.isLoadingNotifier,
      builder: (context, loading, child) {
        if (loading) return Center(child: CircularProgressIndicator());

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

  Widget _buildPhone() {
    final phone = widget.authPhone?.phoneNumber;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.edit, size: 18), Text(phone ?? '')],
    );
  }

  Widget _buildCode() {
    return PinCodeTextField(
      autoFocus: true,
      controller: _codeController,
      length: 6,
      obsecureText: false,
      animationType: AnimationType.fade,
      textInputType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        selectedColor: AppColors.main,
        selectedFillColor: AppColors.textField,
        inactiveColor: AppColors.textField,
        inactiveFillColor: AppColors.textField,
        activeColor: AppColors.textField,
        activeFillColor: AppColors.textField,
        borderRadius: BorderRadius.circular(4),
        fieldHeight: 40,
        fieldWidth: 40,
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      animationDuration: Duration(milliseconds: 150),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onChanged: (value) {
        print(value);
      },
    );
  }

  Widget _buildNoCodeButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: _showTimer,
      builder: (context, value, child) {
        return FlatButton(
          child: Text(Strings.phoneResendCode,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          onPressed: value ? null : _onResend,
        );
      }
    );
  }

  Widget _buildTimer() {
    return ValueListenableBuilder<int>(
      valueListenable: _timerValue,
      builder: (context, value, child) {
        if (value > 0)
          return Text(value.toString());
        return SizedBox();
      },
    );
  }

  void _onNext() {
    final code = _codeController.text;
    if (code.length > 5) {
      widget.authPhone.signInWithPhoneNumber(
          code: code,
          keyScaffold: _keyScaffold,
          onSuccess: () {
            Navigator.pop(context);
          },
          onError: () {
            _keyScaffold.currentState
                .showSnackBar(customSnack("Incorrect code"));
          });
    } else {
      _keyScaffold.currentState
          .showSnackBar(customSnack("Error: Please Enter code"));
    }
  }

  void _onResend() {
    _initTimer();
    widget.authPhone.initVerifyPhoneNumber(
      context: context,
      keyScaffold: _keyScaffold,
    );
  }
}
