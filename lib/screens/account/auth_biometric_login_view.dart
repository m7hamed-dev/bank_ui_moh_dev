import 'package:bank_ui_moh_dev/widgets/my_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BioAuthAPI {
  LocalAuthentication localAuth = LocalAuthentication();
  //
  Future<bool> checkIfDeviceSupportBio() async {
    try {
      bool _canCheckBiometrics = await localAuth.canCheckBiometrics;
      print(_canCheckBiometrics
          ? ' device support bio '
          : 'device is not support');
      return _canCheckBiometrics;
    } on Exception catch (e) {
      if (e is PlatformException) {
        EasyLoading.showError('your device not support');
        return false;
      }
      EasyLoading.showError(e.toString());
      debugPrint('================\n my excp $e ==============\n');
      return false;
    }
  }

  Future<bool> startAuthBio() async {
    if (await checkIfDeviceSupportBio() == false) {
      EasyLoading.showError('your device not support');
      return false;
    }
    bool _didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate to complete transfer balance',
      biometricOnly: false,
      stickyAuth: true,
      androidAuthStrings: AndroidAuthMessages(),
    );
    if (_didAuthenticate) {
      EasyLoading.showSuccess('Your Transfer is completed Success !!');
      return true;
    } else {
      EasyLoading.showError('Erro bio');
      return false;
    }
  }

  Future<void> listOfBios() async {
    try {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
      debugPrint('availableBiometrics = $availableBiometrics');
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
      debugPrint('================\n my excp $e ==============\n');
    }
  }
}

class AuthBiometricLoginView extends StatefulWidget {
  const AuthBiometricLoginView({Key? key}) : super(key: key);

  @override
  _AuthBiometricLoginViewState createState() => _AuthBiometricLoginViewState();
}

class _AuthBiometricLoginViewState extends State<AuthBiometricLoginView> {
  LocalAuthentication localAuth = LocalAuthentication();
  //
  Future<bool> _checkIfDeviceSupportBio() async {
    try {
      bool _canCheckBiometrics = await localAuth.canCheckBiometrics;
      print(_canCheckBiometrics
          ? ' device support bio '
          : 'device is not support');
      return _canCheckBiometrics;
    } on Exception catch (e) {
      if (e is PlatformException) {
        EasyLoading.showError('your device not support');
        return false;
      }
      EasyLoading.showError(e.toString());
      debugPrint('================\n my excp $e ==============\n');
      return false;
    }
  }

  Future<void> _startAuthBio() async {
    if (await _checkIfDeviceSupportBio() == false) {
      return EasyLoading.showError('your device not support');
    }
    bool _didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate to complete transfer balance',
      biometricOnly: false,
      stickyAuth: true,
      androidAuthStrings: AndroidAuthMessages(),
    );
    if (_didAuthenticate) {
      EasyLoading.showSuccess('Great Success!');
    } else {
      EasyLoading.showError('Erro bio');
    }
  }

  Future<void> _listOfBios() async {
    try {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
      debugPrint('availableBiometrics = $availableBiometrics');
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
      debugPrint('================\n my excp $e ==============\n');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfDeviceSupportBio();
  }

  @override
  Widget build(BuildContext context) {
    _checkIfDeviceSupportBio();
    _listOfBios();

    return Scaffold(
      body: Center(
        child: MyBtn(
          onPressed: () {
            _startAuthBio();
          },
        ),
      ),
    );
  }
}
