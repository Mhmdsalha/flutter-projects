import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shered/components/components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview_screen extends StatelessWidget {
  final String Url;
  webview_screen(this.Url);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news_cubit, news_states>(
        listener: (BuildContext context, news_states state) {},
        builder: (BuildContext context, news_states state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: WebView(
                    initialUrl: Url,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
