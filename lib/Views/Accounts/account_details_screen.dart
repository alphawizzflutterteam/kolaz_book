import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kolazz_book/Models/ledger_entries_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/colors.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String? photographerName, pid, type, totalOutstanding;

  const AccountDetailsScreen(
      {Key? key,
      this.photographerName,
      this.pid,
      this.type,
      this.totalOutstanding})
      : super(key: key);

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  bool isClickable = true;
  bool isSelected = true;
  List<LedgerData> ledgerData = [];
  String? totalOutstanding;
  int currentIndex = 0 ;
  String pdfUrl = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  deleteConfirmation(BuildContext context, String? id) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Delete Ledger Entry!',
        style: TextStyle(color: AppColors.textclr),
      ),
      content: const Text(
        'Are you sure you want to delete this ledger entry',
        style: TextStyle(color: AppColors.textclr),
      ),
      actions: [
        TextButton(
          child: Container(
              height: 25,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.AppbtnColor),
              child: const Center(
                  child: Text(
                'No',
                style: TextStyle(color: AppColors.textclr),
              ))),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Container(
              height: 25,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.AppbtnColor),
              child: const Center(
                  child: Text(
                'Yes',
                style: TextStyle(color: AppColors.textclr),
              ))),
          onPressed: () {
            deleteLedgerEntry(context, id);
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  deleteLedgerEntry(BuildContext context, String? id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(deleteLedgerEntriesApi.toString()));
    request.fields.addAll({
      'id': id.toString()
      // 'user_id': userId.toString()
    });
    print(
        "this is delete freelance job request ${request.fields.toString()} and $deleteFreelanceJobApi");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (userData['error'] == false) {
        Fluttertoast.showToast(msg: userData['message']);
        getAccountsData();
        Navigator.pop(context, true);
        // getBroadCastData();

      } else {
        Fluttertoast.showToast(msg: userData['message']);
        // getBroadCastData();
        // Fluttertoast.showToast(msg: userData['msg']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  downloadPdfs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(downloadPdfApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.type] = 'accounts';
    request.fields[RequestKeys.userType] = widget.type.toString();
    request.fields[RequestKeys.filter] =
    isSelected ? 'all' : 'outstanding';
    request.fields[RequestKeys.photographerId] = widget.pid!;
    var response = await request.send();
    print("this is pdf download requests ${request.fields}");
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      pdfUrl = userData['url'];
    });
    _showPdf(pdfUrl);
    print("this is our html content $pdfUrl");
    // downloadPdfs();
  }

  _showPdf(pdf) async {
    print("this is my url $pdf");
    var url = pdf.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could not open this pdf!");
      throw 'Could not launch $url';
    }
  }

  Widget _paymentReceived() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Enter Received Amount",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Enter Short Description(Optional)",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            addAmount('credit');
          },
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 2),
                      blurRadius: 1,
                      color: AppColors.greyColor,
                    )
                  ],
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.greenbtn),

              width: MediaQuery.of(context).size.width / 1.5,
              child: const Center(
                  child: Text("Add Payment",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textclr)))),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget _payout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Add Payout Amount",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Enter Short Description(Optional)",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            addAmount('debit');
          },
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 2),
                      blurRadius: 1,
                      color: AppColors.greyColor,
                    )
                  ],
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.contaccontainerred),
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Center(
                  child: Text("Payout",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textclr)))),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget extraCharge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Enter Extra Charges",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Enter Short Description(Optional)",
                  style: TextStyle(
                      color: AppColors.textclr,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            addAmount("debit");
          },
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(1, 2),
                    blurRadius: 1,
                    color: AppColors.greyColor,
                  )
                ],
                borderRadius: BorderRadius.circular(50),
                color: AppColors.AppbtnColor,
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Center(
                  child: Text("Add Extra Charges",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textclr)))),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  getAccountsData() async {
    print("account initiated!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(ledgerDataApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.userType] =
        widget.type == 'client' ? 'client' : 'photographer';
    request.fields[RequestKeys.photographerId] = widget.pid.toString();

    print(
        "this is ledger request ${request.fields.toString()} and $ledgerDataApi");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      ledgerData = LedgerEntriesModel.fromJson(userData).data!;
      totalOutstanding =
          LedgerEntriesModel.fromJson(userData).totalOutstanding!;
    });
    print("this is =====>>>>> ${ledgerData.length}");
  }

  addAmount(String transactionType) async {
    print("account initiated!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(addPayoutApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.userType] =
        widget.type == 'client' ? 'client' : 'photographer';
    request.fields['amount'] = amountController.text.toString();
    request.fields['description'] = descriptionController.text.toString();
    request.fields['transaction_type'] = transactionType.toString();

    request.fields[RequestKeys.photographerId] = widget.pid.toString();

    print(
        "this is add ledger request ${request.fields.toString()} and $addPayoutApi");
    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    getAccountsData();
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "${userData['message']}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
        child: Container(
          height: 100,
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.teamcard2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(color: AppColors.textclr),
                      ),
                      Text(
                          totalOutstanding != null || totalOutstanding != ''
                              ? '₹ $totalOutstanding'
                              : '₹ 0',
                          style: TextStyle(color: AppColors.textclr)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                Function(Function()) setState) {
                              return
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Container(
                                  height: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: formKey,
                                      child : Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.containerclr,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isSelected = true;
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 14,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Text(
                                                              'Payment Received',
                                                              style: TextStyle(
                                                                color: isSelected
                                                                    ? Color(
                                                                        0xffffffff)
                                                                    : Colors.white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: isSelected
                                                                ? AppColors.greenbtn
                                                                : AppColors
                                                                    .containerclr,
                                                            // border: Border.all(color: AppColors.AppbtnColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                          )),
                                                    ),
                                                    widget.type == 'client'
                                                        ? InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                //   builder: (context) => NextPage(),
                                                                // ));
                                                                isSelected = false;
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 50,
                                                                width: 130,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Add Extra Charges',
                                                                    style:
                                                                        TextStyle(
                                                                      color: isSelected
                                                                          ? AppColors
                                                                              .whit
                                                                          : Colors
                                                                              .white,
                                                                      fontSize: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: isSelected
                                                                        ? AppColors
                                                                            .containerclr
                                                                        : AppColors
                                                                            .AppbtnColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10))),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                //   builder: (context) => NextPage(),
                                                                // ));
                                                                isSelected = false;
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 50,
                                                                width: 130,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Payout',
                                                                    style:
                                                                        TextStyle(
                                                                      color: isSelected
                                                                          ? AppColors
                                                                              .whit
                                                                          : Colors
                                                                              .white,
                                                                      fontSize: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: isSelected
                                                                        ? AppColors
                                                                            .containerclr
                                                                        : AppColors
                                                                            .contaccontainerred,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10))),
                                                          ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          widget.type == 'client'
                                              ? isSelected
                                                  ? _paymentReceived()
                                                  : extraCharge()
                                              : isSelected
                                                  ? _paymentReceived()
                                                  : _payout(),
                                        ],
                                      ),
                                    ),
                                  ),
                              ),
                                );
                            },
                          );
                        },
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddAmountScreen()));
                    },
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 1,
                              color: AppColors.greyColor,
                            )
                          ],
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.pdfbtn),
                      child: const Center(
                        child: Text("Add Amount",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whit)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      downloadPdfs();
                    },
                    child: Image.asset(
                      "assets/images/pdf.png",
                      scale: 2.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgruond,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: AppColors.AppbtnColor)),
        backgroundColor: Color(0xff303030),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
                child: Text("${widget.photographerName} Account",
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.AppbtnColor,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8, top: 30, bottom: 10),
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.teamcard2),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Container(
                      width: 70,
                      child: const Text(
                        "Date",
                        style: TextStyle(color: AppColors.textclr),
                      ),
                    ),
                    Container(
                      width: 140,
                      child: const Text("Description",
                          style: TextStyle(color: AppColors.textclr)),
                    ),
                    Container(
                      width: 60,
                      child: const Text("Credit",
                          style: TextStyle(color: AppColors.textclr)),
                    ),
                  const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("Debit", style: TextStyle(color: AppColors.textclr)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ledgerData.isNotEmpty
              ? Container(
            height: MediaQuery.of(context).size.height/ 1.75,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: ledgerData.length,
                    itemBuilder: (context, k) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        child: InkWell(
                          onLongPress: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                              return deleteConfirmation(
                                  context, ledgerData[k].id.toString());
                            });
                          },
                          onTap: () async {
                           setState(() {
                             currentIndex = k ;
                           });
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return deleteConfirmation(
                                      context, ledgerData[k].id.toString());
                                });
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == k ?
                                     AppColors.AppbtnColor :
                                AppColors.lightwhite),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width : 70,
                                    child: Text(
                                      ledgerData[k].date.toString(),
                                      style: const TextStyle(
                                          color: AppColors.textclr),
                                    ),
                                  ),
                                  Container(
                                      width: 130,
                                      child: Text(
                                          ledgerData[k].description.toString(),
                                          style: const TextStyle(
                                              color: AppColors.textclr))),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: 65,
                                      child: Text(double.parse(ledgerData[k].credit.toString()).toStringAsFixed(0),
                                          style: const TextStyle(
                                              color: AppColors.textclr)),
                                    ),
                                  ),
                                  Container(
                                    // width: 70,
                                    child: Text(double.parse(ledgerData[k].debit.toString()).toStringAsFixed(0),
                                        style: const TextStyle(
                                            color: AppColors.textclr)),
                                  ),
                                  const SizedBox(height: 15,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Center(
                      child: const Text(
                    "No data found!",
                    style: TextStyle(color: AppColors.textclr),
                  ))),


          const SizedBox(height: 300,),
        ],
      ),
    );
  }
}
