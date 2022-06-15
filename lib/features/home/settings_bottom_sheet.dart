import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ubenwa_cart/data/local/local_storage.dart';
import 'package:ubenwa_cart/data/local/storage_keys.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      padding: EdgeInsets.symmetric(
          vertical: kRegularPadding, horizontal: kRegularPadding),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: kLargePadding),
          const SettingsListTile(
            name: "Enable Background Service",
            endTile: CupertinoCustomSwitch(),
          )
        ],
      ),
    );
  }
}

class CupertinoCustomSwitch extends StatefulWidget {
  const CupertinoCustomSwitch({Key? key}) : super(key: key);

  @override
  State<CupertinoCustomSwitch> createState() => _CupertinoCustomSwitchState();
}

class _CupertinoCustomSwitchState extends State<CupertinoCustomSwitch> {
  bool? _status;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: LocalStorage.readBool(StorageKeys.runServiceUpload),
      builder: (context, snapshot) {
        return Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: ubPrimaryColor,
              value: _status ?? (snapshot.data == true ? true : false),
              onChanged: (value) {
                LocalStorage.writeBool(StorageKeys.runServiceUpload, value);

                setState(() {
                  _status = value;
                });
              },
            ));
      },
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final String name;
  final Widget? endTile;

  const SettingsListTile({Key? key, required this.name, this.endTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.ac_unit),
                ),
                SizedBox(width: kSmallPadding),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Spacer(),
            endTile ?? Container()
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: kRegularPadding),
          child: const Divider(),
        )
      ],
    );
  }
}
