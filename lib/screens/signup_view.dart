import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telofarmer_app/services/apis/auth_service.dart';
import 'package:telofarmer_app/models/api/models.dart';
import 'package:telofarmer_app/utils/crypto_rsa.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/routes.dart';
import 'package:telofarmer_app/widgets/dark_button.dart';
import 'package:telofarmer_app/widgets/text_input.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpView();
}

class _SignUpView extends State<SignUpView> {
  // service classes
  final _apiAuthService = AuthService();
  late CryptoRSA _cryptoRSA;
  late dynamic _platformProvider;

  // controllers
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordCheckController;
  late TextEditingController _authorizationCodeController;

  // states
  String _userName = '';
  String _email = '';
  String _password = '';
  String _passwordCheck = '';
  String _authorizationCode = '';
  bool _isLoading = false;
  bool _isQuestionTapped = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<Platform>(context, listen: false);
      print(provider.authEntity.toJson());
    });
  }

  void _initData() async {
    //_initTexts();
  }

  void _initTexts() {
    setState(() {
      _userName = 'hsk9169@gmail.com';
      _email = 'hsk9169@gmail.com';
      _password = 'vh8cl5QpIAKt';
      _passwordCheck = 'vh8cl5QpIAKt';
    });
  }

  void _initControllers() {
    _userNameController = TextEditingController(text: _userName);
    _emailController = TextEditingController(text: _email);
    _passwordController = TextEditingController(text: _password);
    _passwordCheckController = TextEditingController(text: _passwordCheck);
    _authorizationCodeController =
        TextEditingController(text: _authorizationCode);
    _userNameController.addListener(_userNameChanged);
    _emailController.addListener(_emailChanged);
    _passwordController.addListener(_passwordChanged);
    _passwordCheckController.addListener(_passwordCheckChanged);
    _authorizationCodeController.addListener(_authorizationCodeChanged);
  }

  void _userNameChanged() {
    setState(() => _userName = _userNameController.text);
  }

  void _emailChanged() {
    setState(() => _email = _emailController.text);
  }

  void _passwordChanged() {
    setState(() => _password = _passwordController.text);
  }

  void _passwordCheckChanged() {
    setState(() => _passwordCheck = _passwordCheckController.text);
  }

  void _authorizationCodeChanged() {
    setState(() => _authorizationCode = _authorizationCodeController.text);
  }

  void _onTapQuestionMark() {
    setState(() => _isQuestionTapped = true);
  }

  void _onPressedSignUp() async {
    print('sign up');
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
                          _renderGuideText(),
                          _renderTextInputs(),
                          _renderButton(),
                          _isQuestionTapped
                              ? _renderQuestionText()
                              : const SizedBox(),
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
                      fontSize: context.pWidth * 0.04)),
            ]));
  }

  Widget _renderGuideText() {
    return Column(
      children: [
        Text('Please enter your details',
            style: TextStyle(
                color: AppColors.mainColor, fontSize: context.pWidth * 0.04)),
        Padding(padding: EdgeInsets.all(context.pHeight * 0.015))
      ],
    );
  }

  Widget _renderTextInputs() {
    return Column(children: [
      MyTextInput(
          textController: _userNameController,
          hintText: 'Username',
          obscure: false),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
      MyTextInput(
          textController: _emailController, hintText: 'Email', obscure: false),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.01)),
      MyTextInput(
          textController: _passwordController,
          hintText: 'Password',
          obscure: true),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
      MyTextInput(
          textController: _passwordCheckController,
          hintText: 'Repeat Password',
          obscure: true),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
      MyTextInput(
        textController: _authorizationCodeController,
        hintText: 'Authorization Code',
        obscure: false,
        suffixIcon: const Icon(Icons.help_outline_rounded),
        onTapSuffixIcon: _onTapQuestionMark,
      ),
      Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
    ]);
  }

  Widget _renderButton() {
    return MyDarkButton(onPressed: _onPressedSignUp, text: 'Sign up');
  }

  Widget _renderQuestionText() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(context.pHeight * 0.01)),
        Text('Telofarm sent an authorization code',
            style: TextStyle(
                color: AppColors.mainColor, fontSize: context.pWidth * 0.03)),
        Padding(padding: EdgeInsets.all(context.pHeight * 0.005)),
        Text('to the email address you provided.',
            style: TextStyle(
                color: AppColors.mainColor, fontSize: context.pWidth * 0.03)),
      ],
    );
  }
}
