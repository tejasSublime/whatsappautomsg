import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

final phoneListProvider = StateProvider((ref) => <String>[]);
final numProvider = StateProvider((ref) => 0);

class _MyAppState extends ConsumerState<MyApp> {
  final TextEditingController _phoneNum = TextEditingController();
  final TextEditingController _msg = TextEditingController();

  Future callApi() async {}

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> phoneList = ref.watch(phoneListProvider);
    int numValue = ref.watch(numProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("This is the Value $numValue"),
              ),
              TextField(
                // keyboardType: ,
                // maxLength: 10,
                controller: _msg,
                decoration: const InputDecoration(hintText: "Set The Msg"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: _phoneNum,
                decoration:
                    const InputDecoration(hintText: "Input the Phone Number"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_phoneNum.text != "") {
                      ref
                          .watch(phoneListProvider.notifier)
                          .state
                          .add(_phoneNum.text);
                    }
                  },
                  child: const Text("Add Phone")),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: phoneList.length,
                  itemBuilder: (_, index) => Text(phoneList[index]))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.watch(numProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         if (_msg.text != "") {
      //           if (phoneList.isNotEmpty) {
      //             sendsms(msg: _msg.text, phoneNumbers: phoneList);
      //           } else {
      //             Fluttertoast.showToast(msg: "Add Phone numbers");
      //           }
      //           Fluttertoast.showToast(msg: "Set Msg");
      //         }
      //       },
      //       child: const Text("send Msg"),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         print(_msg.text != "");
      //         await sendWAmsg(msg: _msg.text, phoneNumbers: phoneList);
      //         if (_msg.text != "") {
      //           if (phoneList.isNotEmpty) {
      //           } else {
      //             // Fluttertoast.showToast(msg: "Add Phone numbers");
      //           }
      //           // Fluttertoast.showToast(msg: "Set Msg");
      //         }
      //       },
      //       child: const Text("send WhatsApp Msg"),
      //     ),
      //   ],
      // ),
    );
  }
}
