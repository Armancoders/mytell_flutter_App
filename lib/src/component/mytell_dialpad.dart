library flutter_dialpad;

import 'dart:async';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dtmf/dtmf.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class MyTellDialPad extends StatefulWidget {
  final ValueSetter<String>? makeCall;
  final ValueSetter<String>? keyPressed;
  final bool? hideDialButton;
  final bool? hideSubtitle;
  // buttonColor is the color of the button on the dial pad. defaults to Colors.gray
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? dialButtonColor;
  final Color? dialButtonIconColor;
  final IconData? dialButtonIcon;
  final Color? backspaceButtonIconColor;
  final Color? dialOutputTextColor;
  // outputMask is the mask applied to the output text. Defaults to (000) 000-0000
  final String? outputMask;
  final bool? enableDtmf;

  MyTellDialPad(
      {this.makeCall,
      this.keyPressed,
      this.hideDialButton,
      this.hideSubtitle = false,
      this.outputMask,
      this.buttonColor,
      this.buttonTextColor,
      this.dialButtonColor,
      this.dialButtonIconColor,
      this.dialButtonIcon,
      this.dialOutputTextColor,
      this.backspaceButtonIconColor,
      this.enableDtmf});

  @override
  _MyTellDialPadState createState() => _MyTellDialPadState();
}

class _MyTellDialPadState extends State<MyTellDialPad> {
  MaskedTextController? textEditingController;
  var _value = "";
  var mainTitle = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "＃"];
  var subTitle = ["", "", "", "", "", "", "", "", "", null, "+", null];

  @override
  void initState() {
    textEditingController = MaskedTextController(
        mask: widget.outputMask != null ? widget.outputMask : '000 000-0000');
    super.initState();
  }

  _setText(String? value) async {
    if ((widget.enableDtmf == null || widget.enableDtmf!) && value != null)
      Dtmf.playTone(digits: value.trim(), samplingRate: 8000, durationMs: 160);

    if (widget.keyPressed != null) widget.keyPressed!(value!);

    setState(() {
      _value += value!;
      textEditingController!.text = _value;
    });
  }

  List<Widget> _getDialerButtons() {
    var rows = <Widget>[];
    var items = <Widget>[];

    for (var i = 0; i < mainTitle.length; i++) {
      if (i % 3 == 0 && i > 0) {
        rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
        rows.add(SizedBox(
          height: 12,
        ));
        items = <Widget>[];
      }

      items.add(DialButton(
        title: mainTitle[i],
        subtitle: subTitle[i],
        hideSubtitle: widget.hideSubtitle!,
        color: widget.buttonColor,
        textColor: widget.buttonTextColor,
        onTap: _setText,
      ));
    }
    //To Do: Fix this workaround for last row
    rows.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
    rows.add(SizedBox(
      height: 12,
    ));

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.09852217;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              height: Get.height * .1,
              child: TextFormField(
                readOnly: false,
                keyboardType: TextInputType.none,
                style: textTitleXXLarge.copyWith(
                    fontSize: textEditingController!.value.text.length <= 11
                        ? Get.textTheme.displaySmall?.fontSize?.toDouble()
                        : textEditingController!.value.text.length <= 17
                            ? Get.textTheme.headlineLarge?.fontSize?.toDouble()
                            : textEditingController!.value.text.length <= 20
                                ? Get.textTheme.headlineSmall?.fontSize
                                    ?.toDouble()
                                : Get.textTheme.headlineSmall?.fontSize
                                    ?.toDouble(),
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: textEditingController,
              ),
            ),
          ),
          ..._getDialerButtons(),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: widget.hideDialButton != null && widget.hideDialButton!
                    ? Container()
                    : Center(
                        child: DialButton(
                          icon: widget.dialButtonIcon != null
                              ? widget.dialButtonIcon
                              : Icons.phone,
                          color: widget.dialButtonColor != null
                              ? widget.dialButtonColor!
                              : Colors.green,
                          hideSubtitle: widget.hideSubtitle!,
                          onTap: (value) {
                            widget.makeCall!(_value);
                          },
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: screenSize.height * 0.03685504),
                  child: IconButton(
                    icon: Icon(
                      Icons.backspace,
                      size: sizeFactor / 2,
                      color: _value.length > 0
                          ? (widget.backspaceButtonIconColor != null
                              ? widget.backspaceButtonIconColor
                              : Colors.white24)
                          : Colors.white24,
                    ),
                    onPressed: _value.length == 0
                        ? null
                        : () {
                            if (_value.length > 0) {
                              setState(() {
                                _value = _value.substring(0, _value.length - 1);
                                textEditingController!.text = _value;
                              });
                            }
                          },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DialButton extends StatefulWidget {
  final Key? key;
  final String? title;
  final String? subtitle;
  final bool hideSubtitle;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final ValueSetter<String?>? onTap;
  final bool? shouldAnimate;
  DialButton(
      {this.key,
      this.title,
      this.subtitle,
      this.hideSubtitle = false,
      this.color,
      this.textColor,
      this.icon,
      this.iconColor,
      this.shouldAnimate,
      this.onTap});

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  Timer? _timer;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorTween = ColorTween(
            begin: widget.color != null ? widget.color : Colors.white24,
            end: Colors.white)
        .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    if ((widget.shouldAnimate == null || widget.shouldAnimate!) &&
        _timer != null) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.09852217;

    return GestureDetector(
      onTap: () {
        if (this.widget.onTap != null) this.widget.onTap!(widget.title);

        if (widget.shouldAnimate == null || widget.shouldAnimate!) {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          } else {
            _animationController.forward();
            _timer = Timer(const Duration(milliseconds: 200), () {
              setState(() {
                _animationController.reverse();
              });
            });
          }
        }
      },
      onLongPress: () {
        if (widget.subtitle != null) {
          if (widget.subtitle!.isEmpty) return;
          if (this.widget.onTap != null) this.widget.onTap!(widget.subtitle);
        }
      },
      child: ClipOval(
          child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) => Container(
                    color: _colorTween.value,
                    height: sizeFactor,
                    width: sizeFactor,
                    child: Center(
                        child: widget.icon == null
                            ? widget.subtitle != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        widget.title!,
                                        style: textTitleXXLarge.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      if (!widget.hideSubtitle)
                                        Text(widget.subtitle!,
                                            style: TextStyle(
                                                color: widget.textColor != null
                                                    ? widget.textColor
                                                    : Colors.black))
                                    ],
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: widget.title == "*" ? 10 : 0),
                                    child: Text(
                                      widget.title!,
                                      style: TextStyle(
                                          fontSize: widget.title == "*" &&
                                                  widget.subtitle == null
                                              ? screenSize.height * 0.0862069
                                              : sizeFactor / 2,
                                          color: widget.textColor != null
                                              ? widget.textColor
                                              : Colors.black),
                                    ))
                            : Icon(widget.icon,
                                size: sizeFactor / 2,
                                color: widget.iconColor != null
                                    ? widget.iconColor
                                    : Colors.white)),
                  ))),
    );
  }
}
