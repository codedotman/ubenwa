import 'package:flutter/material.dart';
import 'package:ubenwa_cart/data/models/infants_response.dart';
import 'package:ubenwa_cart/utils/constants.dart';

import '../../utils/strings.dart';

class ChildDetailsBottomSheet extends StatelessWidget {
  final InfantDataList infantDataList;
  const ChildDetailsBottomSheet({Key? key, required this.infantDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _keyValueData({required String key, required String value}) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: kRegularPadding),
            child: Row(
              children: [
                Text(
                  '$key: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: gray1Color),
                ),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.3),
          )
        ],
      );
    }

    return Container(
      // height: MediaQuery.of(context).size.height * 0.50,
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
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 50,
              ),
              SizedBox(width: kMediumPadding),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kRegularPadding),
                child: Text(infantDataList.type ?? "",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith()),
              ),
            ],
          ),
          _keyValueData(key: 'Infant ID', value: infantDataList.id ?? ""),
          _keyValueData(
              key: 'Infant Name', value: infantDataList.attributes?.name ?? ""),
          _keyValueData(
              key: 'Gender', value: infantDataList.attributes?.gender ?? ""),
          _keyValueData(
              key: 'Gestation Date',
              value:
                  formatDate(date: infantDataList.attributes?.gestation ?? ""))
        ],
      ),
    );
  }
}
