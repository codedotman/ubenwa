import 'package:flutter/material.dart';
import 'package:ubenwa_cart/components/ub_error_switcher.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/utils/constants.dart';

enum PageState { loading, loaded, noData, error }

class UBPageStateWidget extends StatelessWidget {
  final Stream<Resource>? pageState;
  final WidgetBuilder builder;
  final WidgetBuilder? noDataBuilder;
  final VoidCallback onRetry;
  final String? noDataMessage;
  final String? errorMessage;

  const UBPageStateWidget(
      {required this.pageState,
      required this.builder,
      this.noDataBuilder,
      required this.onRetry,
      required this.noDataMessage,
      this.errorMessage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pageState,
      builder: (context, AsyncSnapshot<Resource> snapshot) {
        Widget pageBody = const SizedBox.shrink();
        if (pageState == null) {
          return Builder(builder: builder);
        }
        if (snapshot.data is Loading) {
          pageBody = const Center(
              child: CircularProgressIndicator(color: ubPrimaryColor));
        } else if (snapshot.data is Success) {
          pageBody = Builder(builder: builder);
        } else if (snapshot.data is Error) {
          pageBody = ErrorSwitcher(
            onRetry: onRetry,
            errorMessage: errorMessage,
          );
        } else {
          return Builder(builder: builder);
        }
        return pageBody;
      },
    );
  }
}
