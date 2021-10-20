import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/login_form.dart';
import 'package:flutter_app/widgets/sign_up_form.dart';
import 'package:flutter_app/widgets/socal_buttons.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween(begin: 0.0, end: 90.0).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignUp ? -_size.width * 0.76 : 0,
                  child: GestureDetector(
                    onTap: updateView,
                    child: Container(
                      color: login_bg,
                      child: LoginForm(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  child: GestureDetector(
                    onTap: updateView,
                    child: Container(
                      color: signup_bg,
                      child: SignUpForm(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  top: _size.height * 0.1,
                  right:
                      _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: _isShowSignUp
                        ? SvgPicture.asset(
                            'assets/icons/animation_logo.svg',
                            color: signup_bg,
                          )
                        : SvgPicture.asset(
                            'assets/icons/animation_logo.svg',
                            color: login_bg,
                          ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  height: _size.height * 0.1,
                  bottom: _size.height * 0.06,
                  right:
                      _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: SocalButtns(),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  left: _isShowSignUp
                      ? 0
                      // 0.88 / 2 = 0.44(login的宽度是 88%);
                      : _size.width * 0.44 - 80,
                  bottom: _isShowSignUp
                      ? _size.height * 0.5 - 80 // 旋转后宽度就是高度 要保持居中需要减去宽度一半
                      : _size.height * 0.3,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                      fontSize: _isShowSignUp ? 20 : 32,
                      color: _isShowSignUp ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: updateView,
                        child: Container(
                          width: 160,
                          padding: EdgeInsets.symmetric(
                            vertical: defpaultPadding * 0.6,
                          ),
                          child: Text(
                            'Log in'.toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  right: !_isShowSignUp
                      ? 0
                      // 0.88 / 2 = 0.44(login的宽度是 88%);
                      : _size.width * 0.44 - 80,
                  bottom: !_isShowSignUp
                      ? _size.height * 0.5 - 80 // 旋转后宽度就是高度 要保持居中需要减去宽度一半
                      : _size.height * 0.3,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                      fontSize: !_isShowSignUp ? 20 : 32,
                      color: !_isShowSignUp ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: updateView,
                        child: Container(
                          width: 160,
                          padding: EdgeInsets.symmetric(
                            vertical: defpaultPadding * 0.6,
                          ),
                          child: Text(
                            'Sign Up'.toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
