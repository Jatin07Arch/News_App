import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailViewScreen extends StatefulWidget {
  String newsUrl;
  DetailViewScreen({super.key, required this.newsUrl});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  bool isLoading = true;
  bool isError = false;
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    widget.newsUrl = widget.newsUrl.contains("http:")
        ? widget.newsUrl.replaceAll("http:", "https:")
        : widget.newsUrl;
  }

  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15, right: 60),
            child: Image.asset(
              "assets/images/logo.png",
              height: 70,
              fit: BoxFit.fill,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF7D1E1F),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: WebView(
                initialUrl: widget.newsUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.complete(webViewController);
                },
                onPageStarted: (String url) {
                  // Page loading started
                  setState(() {
                    isLoading = true; // Show the loader
                    isError = false; // Reset error state
                    loadingProgress = 0; // Reset progress
                  });
                },
                onProgress: (int progress) {
                  // Update loading progress
                  setState(() {
                    loadingProgress = progress;

                    // Hide the loader once 50% progress is reached
                    if (loadingProgress > 50) {
                      isLoading = false;
                    }
                  });
                },
                onPageFinished: (String url) {
                  // Page loading finished
                  setState(() {
                    isLoading = false; // Hide the loader
                  });
                },
                onWebResourceError: (error) {
                  // Handle page loading errors
                  setState(() {
                    isError = true; // Set error state
                    isLoading = false; // Hide the loader
                  });
                },
              ),
            ),
          ),
          // Loading indicator
          if (isLoading && !isError)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 125, 30, 31), // Custom loader color
                ),
              ),
            ),
          // Error message
          if (isError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Oops! Something went wrong.\nPlease check your internet connection and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
