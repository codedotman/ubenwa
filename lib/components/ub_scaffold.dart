import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ubenwa_cart/components/ub_page_state_widget.dart';
import 'package:ubenwa_cart/data/resource.dart';

class UBScaffold extends StatefulWidget {
  /// Extras:
  ///  - Handles different [PageState] widgets using `state`
  const UBScaffold(
      {Key? key,
      this.scaffoldKey,
      this.appBar,
      required this.builder,
      this.noDataBuilder,
      this.floatingActionButton,
      this.backgroundColor = Colors.white,
      this.resizeToAvoidBottomInset = true,
      this.state,
      this.disablePointer = false,
      this.forceAppBar = false,
      this.extendBodyBehindAppBar = false,
      this.disablePopOnBackIfLoading = false,
      this.bottomNavigationBar,
      this.padding})
      : super(key: key);
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final WidgetBuilder builder;
  final WidgetBuilder? noDataBuilder;
  final Widget? floatingActionButton;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;
  final AppState? state;
  final bool disablePointer;
  final bool forceAppBar;
  final bool extendBodyBehindAppBar;
  final bool disablePopOnBackIfLoading;
  final Widget? bottomNavigationBar;

  @override
  TDScaffoldState createState() => TDScaffoldState();
}

class TDScaffoldState extends State<UBScaffold> {
  Stream<Resource> get articlePreviewStream {
    final StreamController<Resource>? _articlePreviewController =
        StreamController.broadcast();
    _articlePreviewController!.sink.add(Resource.success(""));
    return _articlePreviewController.stream;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Theme(
      data: Theme.of(context),
      child: Scaffold(
          key: widget.scaffoldKey,
          appBar: widget.appBar,
          body: Padding(
            padding:
                widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child: AbsorbPointer(
              absorbing: widget.disablePointer,
              child: Stack(
                children: [
                  SizedBox.expand(
                      child: UBPageStateWidget(
                    pageState: widget.state?.pageState ?? articlePreviewStream,
                    builder: widget.builder,
                    noDataBuilder: widget.noDataBuilder,
                    onRetry: widget.state?.onRetry ?? () {},
                    noDataMessage: widget.state?.noDataMessage,
                    errorMessage: widget.state?.errorMessage,
                  )),
                  // _buildBlur(),
                ],
              ),
            ),
          ),
          floatingActionButton: widget.floatingActionButton,
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          bottomNavigationBar:
              // widget.state.pageState == PageState.loaded
              //     ?
              widget.bottomNavigationBar
          // : Container(),
          ),
    );

    return scaffold;
  }
}

// holds page state properties
class AppState {
  final Stream<Resource>? pageState;

  // final PageState pageState;

  /// to show no data default widget, if null doesn't appear
  final String noDataMessage;

  /// when an error is showing, a retry button will be display
  final VoidCallback? onRetry;
  final String? errorMessage;

  const AppState(
      {this.pageState,
      this.noDataMessage = '',
      this.onRetry,
      this.errorMessage});
}
