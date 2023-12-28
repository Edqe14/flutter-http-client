import 'package:flutter/material.dart';
import 'package:flutter_highlighting/themes/monokai.dart';
import 'package:flutter_http_client/components/appBar.dart';
import 'package:flutter_http_client/components/inputs.dart';
import 'package:flutter_http_client/controller/httpStore.dart';
import 'package:get/get.dart';
import 'package:flutter_highlighting/flutter_highlighting.dart';
import 'package:highlighting/languages/xml.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final storeController = Get.put(HttpStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const CustomAppBar(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => CircleAvatar(
                      radius: 4,
                      backgroundColor: storeController.getStatusColor(),
                    )),
                const SizedBox(width: 8),
                const Text(
                  'Response',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                )
              ],
            ),
          ),
          Expanded(
              child: Obx(
            () => Container(
              alignment: shouldCenter() ? Alignment.center : Alignment.topLeft,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFF202020)),
              child: SingleChildScrollView(
                child: getContent(),
              ),
            ),
          )),
          UserInput()
        ],
      )),
    );
  }

  shouldCenter() {
    return storeController.response.value.isEmpty ||
        storeController.loading.value;
  }

  getContent() {
    if (storeController.loading.value) {
      return const CircularProgressIndicator();
    }

    if (storeController.response.value.isNotEmpty) {
      final copyTheme = Map<String, TextStyle>.from(monokaiTheme);
      copyTheme['root'] =
          monokaiTheme['root']!.copyWith(backgroundColor: Colors.transparent);

      return HighlightView(storeController.response.value,
          theme: copyTheme,
          languageId: xml.id,
          textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              fontFamily: 'JetBrainsMono'));
    }

    return const Text('No response');
  }
}
