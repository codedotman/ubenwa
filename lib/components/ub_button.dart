import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class UBButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Color textColor, backgroundColor;
  final bool enable;
  final Stream<bool>? enableStream;
  final Stream<Resource>? loadingStream;

  const UBButton(
      {Key? key,
      required this.title,
      required this.callback,
      this.textColor = Colors.white,
      this.backgroundColor = ubPrimaryColor,
      this.enable = true,
      this.enableStream,
      this.loadingStream})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: enableStream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        bool enabledStream = false;
        if (enableStream == null) {
          enabledStream = true;
        } else {
          if (snapshot.data == true) {
            enabledStream = true;
          }
        }
        return InkWell(
          onTap: enabledStream ? callback : null,
          child: Container(
            height: 50.h,
            width: 120.h,
            decoration: BoxDecoration(
                color: enabledStream ? backgroundColor : navy5Color,
                borderRadius: BorderRadius.circular(15)),
            child: StreamBuilder(
                stream: loadingStream,
                builder: (context, AsyncSnapshot<Resource> loadingSnapshot) {
                  return Center(
                      child: loadingSnapshot.data is Loading
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white)),
                                ),
                              ],
                            )
                          : Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: enabledStream
                                          ? textColor
                                          : navy4Color,
                                      fontWeight: FontWeight.w700),
                            ));
                }),
          ),
        );
      },
    );
  }
}
