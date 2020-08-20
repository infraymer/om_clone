import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPhoneFirebase {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final String phoneNumber;
  final Function timer;
  final Duration timeOut;
  GlobalKey<ScaffoldState> keyScaffold;
  BuildContext context;
  final Function onAuthenticationSuccessful;
  final Function onSendCode;
  final Function onError;

  String enterCode;
  String actualCode;
  String status;
  bool isError;

  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  AuthPhoneFirebase(
      {@required this.phoneNumber,
      this.onError,
      @required this.onSendCode,
      @required this.onAuthenticationSuccessful,
      @required this.context,
      this.timer,
      @required this.keyScaffold,
      this.timeOut = const Duration(seconds: 60)}) {
    initVerifyPhoneNumber(context: context, keyScaffold: keyScaffold, useSentCallback: true);
  }

  void initVerifyPhoneNumber({@required context, @required keyScaffold, bool useSentCallback = false}) {
    this.keyScaffold = keyScaffold;
    this.context = context;

    timer != null ?? timer();

    isLoadingNotifier.value = true;

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: useSentCallback ? _codeSent : _codeSentWithoutCallback,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);

    print("init verifyPhoneNumber $phoneNumber");
  }

  void _codeSent(String verificationId, [int forceResendingToken]) async {
    isLoadingNotifier.value = false;

    this.actualCode = verificationId;

    onSendCode();

    print('Code sent to $phoneNumber');
  }

  void _codeSentWithoutCallback(String verificationId, [int forceResendingToken]) async {
    isLoadingNotifier.value = false;
    this.actualCode = verificationId;
    keyScaffold.currentState.showSnackBar(customSnack('Code sent to $phoneNumber'));
    print('Code sent to $phoneNumber');
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    isLoadingNotifier.value = false;
    this.actualCode = verificationId;

    print("Auto retrieval time out");
  }

  void _verificationFailed(AuthException authException) {
    isLoadingNotifier.value = false;
    keyScaffold.currentState
        .showSnackBar(customSnack('${authException.message}'));
    status = '${authException.message}';

    if (authException.message.contains('not authorized'))
      status = 'Something has gone wrong, please try later';
    else if (authException.message.contains('Network'))
      status = 'Please check your internet connection and try again';
    else
      status = 'Something has gone wrong, please try later';

    print("Error message: " + status);
  }

  void _verificationCompleted(AuthCredential auth) {
    isLoadingNotifier.value = false;
    status = 'Auto retrieving verification code';

    firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        status = 'Authentication successful';

        keyScaffold.currentState
            .showSnackBar(customSnack('Authentication successful'));
        onAuthenticationSuccessful(firebaseAuth, value, true);
      } else {
        keyScaffold.currentState.showSnackBar(
            customSnack('Something has gone wrong, please try later'));

        status = 'Invalid code/invalid authentication';
      }
    }).catchError((error) {
      keyScaffold.currentState.showSnackBar(
          customSnack('Something has gone wrong, please try later'));

      status = 'Something has gone wrong, please try later';
    });
  }

  void signInWithPhoneNumber(
      {@required code,
      @required keyScaffold,
      Function onSuccess,
      Function onError}) {
    this.isError = false;
    isLoadingNotifier.value = true;
    try {
      var _authCredential = PhoneAuthProvider.getCredential(
          verificationId: actualCode, smsCode: code);

      firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
        this.isError = true;

        //if(error.details != null){
        keyScaffold.currentState.showSnackBar(customSnack(error.message));
        //}

        status = 'Something has gone wrong, please try later';
      }).then((user) {
        isLoadingNotifier.value = false;

        if (isError) {
          onError();
        } else {
          print("user.user.uid");
          print(user.user.uid);
          onSuccess();

          onAuthenticationSuccessful(firebaseAuth, user, false);

          status = 'Authentication successful';
        }
      });
    } catch (error) {
      print(error);
    }
  }
}

customSnack(text) {
  return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.black);
}
