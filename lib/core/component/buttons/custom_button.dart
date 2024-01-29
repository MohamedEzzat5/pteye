import 'package:flutter/material.dart';
import 'package:pteye/core/utils/media_query_values.dart';

import '../../utils/constance.dart';
import '../animation/tap_effect.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback _onTap;
  final Widget? _child;
  final String? _title;
  final Color? _color;
  final Color? _borderColor;
  final Color? _textColor;
  final double? _width;
  final double? _height;
  final double? _fontSize;
  final bool _isRounded;
  final bool _isOutlined;
  final bool _widerPadding;
  final bool _loading;

  const CustomButton({
    super.key,
    required VoidCallback onTap,
    Widget? child,
    String? title,
    Color? color,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? fontSize,
    double? height,
    bool isRounded = true,
    bool isOutlined = false,
    bool widerPadding = false,
    bool loading = false,
  })  : _onTap = onTap,
        _child = child,
        _title = title,
        _color = color,
        _borderColor = borderColor,
        _textColor = textColor,
        _width = width,
        _fontSize = fontSize,
        _height = height,
        _isRounded = isRounded,
        _isOutlined = isOutlined,
        _widerPadding = widerPadding,
        _loading = loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width ?? context.width,
      height: (_height ?? context.height),
      child: TapEffect(
        isClickable: !_loading,
        onClick: _loading ? null : _onTap,
        child: MaterialButton(
          color: _isOutlined
              ? Colors.transparent
              : (_color ?? Theme.of(context).primaryColor),
          highlightElevation: 0,
          onPressed: _loading ? () {} : _onTap,
          padding: !_widerPadding
              ? EdgeInsets.symmetric(vertical: context.toPadding, horizontal: context.toPadding)
              : EdgeInsets.symmetric(vertical: context.toPadding, horizontal: context.toPadding),
          elevation: 0,
          shape: _isRounded
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.height),
                  side: BorderSide(
                    color: _borderColor ?? Theme.of(context).primaryColor,
                    width: context.width * 1.5,
                  ))
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.height),
                  side: BorderSide(
                      color: _borderColor ?? Theme.of(context).primaryColor,
                      width: context.width*1.5),
                ),
          child: _loading
              ? const SpinKitFadingCircle(color: kPrimaryColor,)
              : _title != null
                  ? Center(
                      child: Text(
                        _title!,
                        // style: TextStyles()
                        //     .getRegularStyle(fontSize: _fontSize ?? 14)
                        //     .customColor(_textColor ?? Colors.white),
                      ),
                    )
                  : _child ?? const SizedBox(),
        ),
      ),
    );
  }
}
