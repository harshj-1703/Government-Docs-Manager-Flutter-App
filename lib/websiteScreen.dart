import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSiteScreen extends StatefulWidget {
  final String url;

  const WebSiteScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebSiteScreen> createState() => _WebSiteScreenState();
}

class _WebSiteScreenState extends State<WebSiteScreen> {
  late final WebViewController _controller;
  var progressBar = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progressBar = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Government Docs Manager"),
          backgroundColor: Color.fromARGB(255, 0, 96, 192),
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 146, 189, 232),
                  Color.fromARGB(255, 0, 96, 192),
                  Color.fromARGB(255, 0, 76, 153),
                  Color.fromARGB(255, 0, 96, 192),
                  Color.fromARGB(255, 146, 189, 232),
                ],
              ),
            ),
            child: WebViewWidget(controller: _controller),
          ),
          if (isLoading)
            Center(
              child: Container(
                width: 200,
                child: LinearProgressIndicator(
                  value: progressBar / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 0, 96, 192),
                  ),
                ),
              ),
            ),
        ]));
  }
}
