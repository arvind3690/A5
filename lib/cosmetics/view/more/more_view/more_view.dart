import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:ambrosia_ayurved/cosmetics/common/color_extension.dart';
import 'package:ambrosia_ayurved/cosmetics/view/more/more_view/about_us/about_us.dart';
import 'package:ambrosia_ayurved/cosmetics/view/more/more_view/contact/contact_us.dart';
import 'package:ambrosia_ayurved/cosmetics/view/more/more_view/payment_details_view/payment_details_view.dart';
import 'package:ambrosia_ayurved/cosmetics/view/more/more_view/order_history/order_history_screen.dart';
import 'package:ambrosia_ayurved/home/signin.dart';
import 'package:ambrosia_ayurved/internet/internet.dart';
import 'package:ambrosia_ayurved/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    List moreArr = [
      {
        "index": "1",
        "name": "Payment Details",
        "image": "assets/images/more_payment.png",
        "base": 0
      },
      {
        "index": "2",
        "name": "My Orders",
        "image": "assets/images/more_my_order.png",
        "base": 0
      },
      {
        "index": "3",
        "name": "About Us",
        "image": "assets/images/more_info.png",
        "base": 0
      },
      {
        "index": "4",
        "name": "Contact Us",
        "image": "assets/images/call.png",
        "base": 0
      },
      {
        "index": "5",
        "name": user == null ? "Login" : "Logout",
        "image": "assets/images/logout.png",
        "base": 0
      },
    ];

    return BasePage(
      fetchDataFunction: () async {},
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: FadeInDown(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Acolors.primary,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "More",
                                    style: TextStyle(
                                        color: Acolors.primaryText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: moreArr.length,
                                itemBuilder: (context, index) {
                                  var mObj = moreArr[index] as Map? ?? {};
                                  var countBase = mObj["base"] as int? ?? 0;
                                  return InkWell(
                                    onTap: () {
                                      switch (mObj["index"].toString()) {
                                        case "1":
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PaymentDetailsView()));

                                          break;
                                        case "2":
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderHistoryScreen()));

                                          break;

                                        case "3":
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AboutUsScreen()));
                                          break;

                                        case "4":
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ContactUsPage()));
                                          break;
                                        case "5":
                                          if (user == null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInScreen(),
                                                ));
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Logout"),
                                                  content: Text(
                                                      "Are you sure you want to logout?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Provider.of<UserProvider>(
                                                                context,
                                                                listen: false)
                                                            .logout(context);
                                                      },
                                                      child: Text("Logout"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                        default:
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: Acolors.textfield,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: const EdgeInsets.only(
                                                right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Acolors.placeholder,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                      mObj["image"].toString(),
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.contain),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    mObj["name"].toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Acolors.primaryText,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                if (countBase > 0)
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.5)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      countBase.toString(),
                                                      style: const TextStyle(
                                                          color: Acolors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Acolors.textfield,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Acolors.primary,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 1),
                                                    )
                                                  ]),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 17,
                                              )
                                              // Image.asset("assets/images/btn_back.png",
                                              //     width: 10,
                                              //     height: 10,
                                              //     color: Acolors.primaryText),
                                              ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNav(
          //   selectedIndex: 3,
          // ),
        ),
      ),
    );
  }
}
