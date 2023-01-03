import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telofarmer_app/services/apis/auth_service.dart';
import 'package:telofarmer_app/models/auth/models.dart';
import 'package:telofarmer_app/utils/crypto_rsa.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/widgets/text_input.dart';
import 'package:telofarmer_app/widgets/bright_button.dart';
import 'package:telofarmer_app/widgets/dark_button.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/routes.dart';

class SignInView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  // service classes
  final _apiAuthService = AuthService();
  late CryptoRSA _cryptoRSA;
  late dynamic _sessionProvider;

  // controllers
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;

  // states
  //String _userName = '';
  String _userName = 'hsk9169@gmail.com';
  //String _password = '';
  String _password = 'vh8cl5QpIAKt';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _sessionProvider = Provider.of<Session>(context, listen: false);
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _initControllers() {
    _userNameController = TextEditingController(text: _userName);
    _passwordController = TextEditingController(text: _password);
    _userNameController.addListener(_userNameChanged);
    _passwordController.addListener(_passwordChanged);
  }

  void _initData() async {
    final PublicKey pubKeyInfo = await _apiAuthService.getCryptoInfo();
    _cryptoRSA = CryptoRSA(publicKeyPemBase64: pubKeyInfo.publicKey);
  }

  void _userNameChanged() {
    setState(() => _userName = _userNameController.text);
  }

  void _passwordChanged() {
    setState(() => _password = _passwordController.text);
  }

  void _onPressedSignIn() async {
    setState(() => _isLoading = true);
    final secret = await _cryptoRSA.makePasswordSecret(_password);
    await _apiAuthService.signIn(_userName, secret).then((authEntity) {
      setState(() => _isLoading = false);
      if (authEntity.runtimeType == String) {
        print('Error');
      } else {
        _sessionProvider.authEntity = authEntity;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.SERVICE, (Route<dynamic> route) => false,
            arguments: 0);
      }
    });
  }

  void _onPressedSignUp() {
    Navigator.pushNamed(context, Routes.SIGNUP);
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: _isLoading,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                top: false,
                bottom: false,
                child: Stack(children: [
                  Container(
                      width: context.pHeight,
                      height: context.pHeight,
                      padding: EdgeInsets.only(
                        top: context.pHeight * 0.2,
                        bottom: context.pHeight * 0.02,
                        left: context.pWidth * 0.15,
                        right: context.pWidth * 0.15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _renderLogo(),
                          _renderTextInputs(),
                          _renderButtons(),
                          _renderInfoTexts(),
                        ],
                      )),
                  _isLoading
                      ? Container(
                          width: context.pHeight,
                          height: context.pHeight,
                          color: Colors.grey.withOpacity(0.5),
                          child: Center(
                              child: CupertinoActivityIndicator(
                            animating: true,
                            radius: context.pWidth * 0.05,
                          )))
                      : const SizedBox()
                ]))));
  }

  Widget _renderLogo() {
    return Container(
        alignment: Alignment.center,
        width: context.pWidth,
        height: context.pHeight * 0.25,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/telofarm_logo.svg',
                width: context.pWidth * 0.4,
              ),
              Padding(padding: EdgeInsets.all(context.pHeight * 0.01)),
              Text('Telofarmer',
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: context.pWidth * 0.035)),
            ]));
  }

  Widget _renderTextInputs() {
    return Column(children: [
      MyTextInput(
        textController: _userNameController,
        hintText: 'Username',
        obscure: false,
      ),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
      MyTextInput(
        textController: _passwordController,
        hintText: 'Password',
        obscure: true,
      ),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
    ]);
  }

  Widget _renderButtons() {
    return Column(children: [
      MyDarkButton(onPressed: _onPressedSignIn, text: 'Login'),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.002)),
      MyBrightButton(onPressed: _onPressedSignUp, text: 'Sign up'),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.03)),
    ]);
  }

  Widget _renderInfoTexts() {
    return Column(children: [
      Text('Plants have been Speaking.',
          style: TextStyle(
              color: AppColors.mainColor, fontSize: context.pWidth * 0.04)),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
      Text('Now we can listen.',
          style: TextStyle(
              color: AppColors.mainColor, fontSize: context.pWidth * 0.04)),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.025)),
      Text('telofarm.com',
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: context.pWidth * 0.04,
              fontWeight: FontWeight.bold)),
    ]);
  }
}
