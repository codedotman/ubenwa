import 'package:flutter/material.dart';
import 'package:ubenwa_cart/data/models/infants_response.dart';
import 'package:ubenwa_cart/features/home/child_details_bottom_sheet.dart';
import 'package:ubenwa_cart/features/home/settings_bottom_sheet.dart';

_createExtensibleDialogWidget(
  Widget body,
  BuildContext context, {
  bool overlapContainer = false,
}) {
  return SafeArea(
    top: true,
    bottom: false,
    child: Container(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              overlapContainer
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        height: 10,
                      ),
                    )
                  : Container(),
              body,
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const SizedBox()),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> showSettingsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        const SettingsBottomSheet(),
        context,
      );
    },
  );
}

Future<void> showInfantDataBottomSheet(BuildContext context,
    {required InfantDataList infantDataList}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        ChildDetailsBottomSheet(infantDataList: infantDataList),
        context,
      );
    },
  );
}
