import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GithubWebview extends StatefulWidget {
  const GithubWebview({Key? key}) : super(key: key);

  @override
  State<GithubWebview> createState() => _GithubWebviewState();
}

class _GithubWebviewState extends State<GithubWebview> {
  String url = "https://github.com/CephasPeter";
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      )
  );
  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Github Profile",
              style: Theme.of(context).textTheme.titleMedium
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              height: 1.0,
              color: Theme.of(context).colorScheme.outline,
            )
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.background,
            statusBarIconBrightness: Theme.of(context).colorScheme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
            systemNavigationBarColor: Theme.of(context).colorScheme.background,
            systemNavigationBarIconBrightness: Theme.of(context).colorScheme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(url)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onLoadStop: (controller, url) async {
                  webViewController = controller;
                  pullToRefreshController.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {
                  webViewController = controller;
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  webViewController = controller;
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  if(mounted){
                    setState(() {
                      this.progress = progress / 100;
                    });
                  }
                },
              ),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress,color: Theme.of(context).colorScheme.primary)
                  : Container(),
            ],
          ),
        )
    );
  }

}