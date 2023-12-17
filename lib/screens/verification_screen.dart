import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../network/api.dart';
import '../network/g_sheet.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({super.key, required this.id, required this.loc});

  String id;
  String loc;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GSheet gSheet = GSheet();
  List<UserData> idList = [];
  UserData userData = UserData();
  String verified = "Checking";

  bool isHttp = false;
  Http httpApi = Http();

  // ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();

  @override
  initState() {
    getList();
    checkConnection();
    userData = UserData(loc: widget.loc,id: widget.id);
    super.initState();
  }

  checkConnection() async {
    await connectivity.checkConnectivity().then(
          (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                value == ConnectivityResult.none ? Colors.red : Colors.green,
                content: Text(
                  value == ConnectivityResult.none
                      ? "No Connection available. Please click on the user info to try again"
                      : '${value.name} Connection available, checking user status',
                ),
              ),
            );
            if (value.toString().toUpperCase() == "NONE"){
              setState(() {
                verified = "No internet connection";
              });
            }
          }
        );
  }

  getList() async {
    isHttp ? idList = await httpApi.fetchDataFromAPI() :  idList = await gSheet.sheetFunc();
    if (idList.isNotEmpty) {
      for (var i in idList) {
        if (i.loc == userData.loc && i.id == userData.id) {
          verified = "Verified";
          return;
        } else {
          verified = "Not Verified";
        }
      }
    } else {
      getList();
      update();
    }
  }

  update() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    update();
    return WillPopScope(
      onWillPop: () async {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const QrScanView(),
        // ));
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('User Status'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const QrScanView(),
                    // ));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.home)),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        getList();
                        checkConnection();
                      },
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('User status: $verified',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text('User Member ID is ${widget.id}'),
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
