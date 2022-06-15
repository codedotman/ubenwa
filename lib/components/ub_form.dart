import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class UBForm extends StatefulWidget {
  final String? labelText, suffixText;
  final String hintText;
  final bool forPassword, enable;
  final EdgeInsetsGeometry padding;
  final Color? fillColor;
  final Color inputTextColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final Color labelColor;
  final Color? border;
  final EdgeInsetsGeometry contentPadding;
  final Widget? suffixIcon, suffixWidget;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextStyle hintStyle;
  final Widget? prefix;
  final Widget? prefixIcon;

  const UBForm(
      {Key? key,
      this.enable = true,
      this.labelText,
      required this.hintText,
      this.forPassword = false,
      this.padding = const EdgeInsets.symmetric(vertical: 10),
      this.fillColor = grayColor,
      this.contentPadding = const EdgeInsets.all(0),
      this.onChange,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.inputTextColor = grayBlackColor,
      this.focusedBorderColor = ubPrimaryColor,
      this.enabledBorderColor = gray5Color,
      this.labelColor = Colors.white,
      this.hintStyle = const TextStyle(color: Colors.grey),
      this.disabledBorderColor = ubPrimaryColor,
      this.suffixText,
      this.border,
      this.prefixIcon,
      this.prefix,
      this.suffixWidget})
      : super(key: key);

  @override
  _CXFormState createState() => _CXFormState();
}

class _CXFormState extends State<UBForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: kRegularPadding),
            child: Text(
              widget.hintText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: deepDarkBlueColor, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: kPadding),
          SizedBox(
            height: 50.h,
            child: TextFormField(
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              enabled: widget.enable,
              onChanged: widget.onChange,
              cursorColor: ubPrimaryColor,
              obscureText: widget.forPassword && showPassword,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: grayBlackColor,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                  suffixIcon: widget.suffixWidget,
                  suffixText: widget.suffixText,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: kMediumPadding),
                  prefix: widget.prefix,
                  prefixIcon: widget.prefixIcon,
                  fillColor: widget.fillColor,
                  filled: true,
                  suffix: widget.forPassword
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: showPassword
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                  size: 15,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: 15,
                                ))
                      : (widget.suffixIcon),
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(color: widget.labelColor),
                  hintStyle: widget.hintStyle,
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: ubPrimaryColor)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
