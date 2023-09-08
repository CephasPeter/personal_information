import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../webview/github_webview.dart';

enum ScreenSize { small, medium, large }

const _breakpoint1 = 600.0;
const _breakpoint2 = 840.0;

ScreenSize getScreen(double width) {
  if (width < _breakpoint1) {
    return ScreenSize.small;
  } else if (width >= _breakpoint1 && width <= _breakpoint2) {
    return ScreenSize.medium;
  } else {
    return ScreenSize.large;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width =  MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Slack Information",style: Theme.of(context).textTheme.titleMedium),
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
      body: SizedBox(
        width: double.infinity,
        child: getScreen(width) == ScreenSize.large
            ? largeScreenWidget(context, width, height)
            : normalScreenWidget(context, width, height),
      ),
    );
  }

  Widget normalScreenWidget(BuildContext context, double width, double height) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Theme.of(context).colorScheme.outline,width: 2)
                      ),
                      child: Image.asset(
                          "assets/images/slack_profile_image.jpg",
                          width: width * 0.95,
                          height: width * 0.95,
                          fit: BoxFit.cover
                      )
                  )
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: SelectableText("Cephas",style: Theme.of(context).textTheme.titleLarge),
            ),
            Row(
              children: [
                const SizedBox(width: 12),
                Icon(Icons.email_rounded,size: 20,color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: const EdgeInsets.only(left: 4,right: 12),
                  child: SelectableText("cephasarowolo@gmail.com",style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: (){
                  navigateToGithubWebview();
                },
                style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                label: const Text("Open Github Profile"),
                icon: const Icon(Icons.link_rounded),
              ),
            ),
          ],
        ),
    );
  }

  Widget largeScreenWidget(BuildContext context, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Theme.of(context).colorScheme.outline,width: 2)
                    ),
                    child: Image.asset(
                        "assets/images/slack_profile_image.jpg",
                        width: width * 0.45,
                        height: double.infinity,
                        fit: BoxFit.cover
                    )
                )
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12),
                        child: SelectableText("Cephas",style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Icon(Icons.email_rounded,size: 20,color: Theme.of(context).colorScheme.primary),
                          Padding(
                            padding: const EdgeInsets.only(left: 4,right: 12),
                            child: SelectableText("cephasarowolo@gmail.com",style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: (){
                            navigateToGithubWebview();
                          },
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          label: const Text("Open Github Profile"),
                          icon: const Icon(Icons.link_rounded),
                        ),
                      ),
                    ],
                  )
              )
          )
        ],
      ),
    );
  }

  void navigateToGithubWebview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GithubWebview()),
    );
  }
}