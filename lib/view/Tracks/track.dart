// import 'package:farmacie_stilo/util/images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyWebView extends ConsumerWidget {
//   final String initialUrl = 'https://gls-group.com/GROUP/en/parcel-tracking';
//   late WebViewController _webViewController;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool _isInternalUrl(String url) {
//       return url.startsWith('https://gls-group.com');
//     }

//     void _hideHeaderAndFooter() async {
//       await _webViewController.evaluateJavascript(
//         """
//     var header = document.querySelector('header');
//     var footer = document.querySelector('footer');
//     document.body.style.backgroundColor = 'white !important';

//     if (header) {
//       header.style.display = 'none';
//     }
//     if (footer) {
//       footer.style.display = 'none';
//     }

//     // Create a custom footer
//     // var customFooter = document.createElement('div');
//     // customFooter.style.backgroundColor = 'grey';
//     // customFooter.style.padding = '10px';
//     // customFooter.style.textAlign = 'center';
//     // customFooter.style.width = '100%'; // Set width to 100%
//     // customFooter.style.height = '100vh'; // Set height to 100% of viewport height
//     // customFooter.innerHTML = 'This is a custom footer';
//     // document.body.appendChild(customFooter);
//     """,
//       );

//       ref.read(isShowingProviders.notifier).hideHeaderAndFooter();
//     }

//     final isShowing = ref.watch(isShowingProviders);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1b13af),
//         title: Container(
//             width: MediaQuery.of(context).size.width * 0.2,
//             child: Image.asset(Images.glsLogo)),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: initialUrl,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;
//             },
//             onPageStarted: (String url) {
//               // Show circular progress indicator when page starts loading
//               ref.read(isShowingProviders.notifier).showProgress();
//               _hideHeaderAndFooter();
//             },
//             onPageFinished: (String url) {
//               // Hide circular progress indicator when page finishes loading
//               ref.read(isShowingProviders.notifier).hideProgress();
//               _hideHeaderAndFooter();
//             },
//             navigationDelegate: (NavigationRequest request) {
//               if (_isInternalUrl(request.url)) {
//                 return NavigationDecision.navigate;
//               } else {
//                 return NavigationDecision.prevent;
//               }
//             },
//           ),
//           if (isShowing.progress)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }

// final isShowingProviders =
//     StateNotifierProvider<IsShowingNotifiers, IsShowingState>(
//         (ref) => IsShowingNotifiers());

// class IsShowingNotifiers extends StateNotifier<IsShowingState> {
//   IsShowingNotifiers() : super(IsShowingState(false, false));

//   void hideHeaderAndFooter() {
//     state = state.copyWith(isShowing: true);
//   }

//   void showProgress() {
//     state = state.copyWith(progress: true);
//   }

//   void hideProgress() {
//     state = state.copyWith(progress: false);
//   }
// }

// class IsShowingState {
//   final bool isShowing;
//   final bool progress;

//   IsShowingState(this.isShowing, this.progress);

//   IsShowingState copyWith({bool? isShowing, bool? progress}) {
//     return IsShowingState(
//       isShowing ?? this.isShowing,
//       progress ?? this.progress,
//     );
//   }
// }
import 'dart:io' show Platform;
import 'package:farmacie_stilo/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWebView extends ConsumerWidget {
  final String initialUrl = 'https://gls-group.com/GROUP/en/parcel-tracking';
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isInternalUrl(String url) {
      return url.startsWith('https://gls-group.com');
    }

    void _hideHeaderAndFooter() async {
      await _webViewController.evaluateJavascript(
        """
    var header = document.querySelector('header');
    var footer = document.querySelector('footer');
    document.body.style.backgroundColor = 'white !important';

    if (header) {
      header.style.display = 'none';
    }
    if (footer) {
      footer.style.display = 'none';
    }

    // Create a custom footer
    // var customFooter = document.createElement('div');
    // customFooter.style.backgroundColor = 'grey';
    // customFooter.style.padding = '10px';
    // customFooter.style.textAlign = 'center';
    // customFooter.style.width = '100%'; // Set width to 100%
    // customFooter.style.height = '100vh'; // Set height to 100% of viewport height
    // customFooter.innerHTML = 'This is a custom footer';
    // document.body.appendChild(customFooter);
    """,
      );

      ref.read(isShowingProviders.notifier).hideHeaderAndFooter();
    }

    final isShowing = ref.watch(isShowingProviders);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1b13af),
        title: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Image.asset(Images.glsLogo)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Platform.isAndroid || Platform.isIOS
          ? Stack(
              children: [
                WebView(
                  initialUrl: initialUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController = webViewController;
                  },
                  onPageStarted: (String url) {
                    // Show circular progress indicator when page starts loading
                    ref.read(isShowingProviders.notifier).showProgress();
                    _hideHeaderAndFooter();
                  },
                  onPageFinished: (String url) {
                    // Hide circular progress indicator when page finishes loading
                    ref.read(isShowingProviders.notifier).hideProgress();
                    _hideHeaderAndFooter();
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (_isInternalUrl(request.url)) {
                      return NavigationDecision.navigate;
                    } else {
                      return NavigationDecision.prevent;
                    }
                  },
                ),
                if (isShowing.progress)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            )
          : Container(
              child: FutureBuilder<void>(
                future: _launchURL(initialUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('Opened in browser');
                    }
                  }
                },
              ),
            ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

final isShowingProviders =
    StateNotifierProvider<IsShowingNotifiers, IsShowingState>(
        (ref) => IsShowingNotifiers());

class IsShowingNotifiers extends StateNotifier<IsShowingState> {
  IsShowingNotifiers() : super(IsShowingState(false, false));

  void hideHeaderAndFooter() {
    state = state.copyWith(isShowing: true);
  }

  void showProgress() {
    state = state.copyWith(progress: true);
  }

  void hideProgress() {
    state = state.copyWith(progress: false);
  }
}

class IsShowingState {
  final bool isShowing;
  final bool progress;

  IsShowingState(this.isShowing, this.progress);

  IsShowingState copyWith({bool? isShowing, bool? progress}) {
    return IsShowingState(
      isShowing ?? this.isShowing,
      progress ?? this.progress,
    );
  }
}
