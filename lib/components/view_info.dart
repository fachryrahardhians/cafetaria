// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:admin_repository/admin_repository.dart';
import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewInfo extends StatefulWidget {
  final InfoModel infoModel;
  const ViewInfo({Key? key, required this.infoModel}) : super(key: key);

  @override
  State<ViewInfo> createState() => _ViewInfoState();
}

class _ViewInfoState extends State<ViewInfo> {
  WebViewController? _con;

  String setHTML(String uri) {
    return ('''
    <html>
      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      </head>
    
        <body style="background-color:#fff;height:100vh ">
          $uri
        </body>
      </html>
    ''');
  }

  _loadHTML(String data) async {
    _con!.loadUrl(Uri.dataFromString(setHTML(data),
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  String convertDateTime(DateTime? dateTime) {
    String month;

    switch (dateTime?.month) {
      case 1:
        month = 'Januari';
        break;
      case 2:
        month = 'Febuari';
        break;
      case 3:
        month = 'Maret';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'Mei';
        break;
      case 6:
        month = 'Juni';
        break;
      case 7:
        month = 'Juli';
        break;
      case 8:
        month = 'Agustus';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Oktober';
        break;
      case 11:
        month = 'November';
        break;
      default:
        month = 'Desember';
    }

    return '${dateTime?.day} $month ${dateTime?.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 18, top: 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          convertDateTime(DateTime.parse(
                              widget.infoModel.publishDate.toString())),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    width: 500,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.brown,
                        image: DecorationImage(
                            image: NetworkImage(widget.infoModel.image == null
                                ? "https://i.pinimg.com/564x/94/17/82/941782f60e16a9d7f9b4cea4ae7025e0.jpg"
                                : widget.infoModel.image!),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, top: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.infoModel.title.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, top: 15),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / 1.16,
                          child: WebView(
                            initialUrl: 'https://flutter.dev',
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) async {
                              // _controller.complete(webViewController);
                              _con = webViewController;
                              _loadHTML(DeltaToHTML.encodeJson(
                                  widget.infoModel.body));
                            },
                            onProgress: (int progress) {
                              print(
                                  "WebView is loading (progress : $progress%)");
                            },
                            navigationDelegate: (NavigationRequest request) {
                              if (request.url
                                  .startsWith('https://www.youtube.com/')) {
                                print('blocking navigation to $request}');
                                return NavigationDecision.prevent;
                              }
                              print('allowing navigation to $request');
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              print('Page started loading: $url');
                            },
                            onPageFinished: (String url) {
                              print('Page finished loading: $url');
                            },
                            gestureNavigationEnabled: true,
                          ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
