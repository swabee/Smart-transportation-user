import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/custom/textfield_custom.dart';
import 'package:user_app/features/common_methos/common_methos.dart';
import 'package:user_app/features/customer_setting/customer_profile/presentation/bloc/user_data_bloc.dart';
import 'package:user_app/service_locator/service_locator.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = locator<FirebaseFirestore>();
    final FirebaseFirestore firebaseAuth = locator<FirebaseFirestore>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('E-Wallet'),
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoaded) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Available Balance
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ContainerCustom(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextCustomWidget(
                                  text: 'Available Balance',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  containerAlignment: Alignment.center,
                                ),
                                const SizedBox(height: 8),
                                BlocBuilder<UserDataBloc, UserDataState>(
                                  builder: (context, state) {
                                    if (state is UserDataLoaded) {
                                      return TextCustomWidget(
                                        text: state.userDataEntity.walletBalance
                                            .toString(),
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: primaryColor,
                                        containerAlignment: Alignment.center,
                                      );
                                    }
                                    return const TextCustomWidget(
                                        text: 'Loding..');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Recharge Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RechargeScreen(),
                                ),
                              );
                            },
                            child: const Text('Recharge Wallet'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Transaction History Title
                        const Text(
                          'Transaction History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        StreamBuilder<QuerySnapshot>(
                          stream: firestore
                              .collection('users')
                              .doc(state.userDataEntity.id)
                              .collection(
                                  'transactions') // Fetches all transactions
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No transactions found.'));
                            }

                            // Extract transaction data
                            final transactions = snapshot.data!.docs
                                .map((doc) => doc.data())
                                .toList();

                            return ContainerCustom(
                              height: 600.h,
                              // bgColor: primaryColor,
                              child: ListView.builder(
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = transactions[index]
                                      as Map<String, dynamic>;
                                  return ListTile(
                                    leading: Icon(
                                      (!transaction['isCredited'])
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: (transaction['isCredited'])
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    title: TextCustomWidget(
                                      text: transaction['title'] ?? 'No title',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitle: TextCustomWidget(
                                      text: transaction['content'],
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor:             (transaction['isCredited'])
                                          ? Colors.green
                                          : Colors.red, 
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),

                // Transaction History List
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       return ListTile(
                // leading: Icon(
                //   index % 2 == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                //   color: index % 2 == 0 ? Colors.green : Colors.red,
                // ),
                //         title: Text(
                //           index % 2 == 0 ? 'Received ₹500' : 'Sent ₹300',
                //         ),
                //         subtitle: const Text('01 Jan 2025'),
                //         trailing: Text(
                //           index % 2 == 0 ? '+₹500' : '-₹300',
                //           style: TextStyle(
                //             color: index % 2 == 0 ? Colors.green : Colors.red,
                //           ),
                //         ),
                //       );
                //     },
                //     childCount: 5, // Example transaction count
                //   ),
                // ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  bool inProgress = false;
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recharge Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextFieldCustom(
              onChanged: (value) {
                setState(() {});
              },
              controller: amountController,
              keyboardType: TextInputType.number,
              labelText: 'Enter the Amount',
              labelstyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<UserDataBloc, UserDataState>(
              builder: (context, state) {
                if (state is UserDataLoaded) {
                  return ButtonCustom(
                    inProgress: inProgress,
                    isDisabled: amountController.text.isEmpty,
                    margin: EdgeInsets.only(top: 70.h),
                    btnColor: primaryColor,
                    text: 'Recharge',
                    callback: () async {
                      setState(() {
                        inProgress = true;
                      });
                      try {
                        await addTranscationHistory(
                            content: 'Rs ${amountController.text} Credited',
                            title: 'Wallet Recharge',
                            isCredit: true);
                        await addNotification(
                            content: 'Rs ${amountController.text} Credited',
                            title: 'Wallet Recharge',
                            type: 'payment');
                        setState(() {
                          inProgress = false;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(state.userDataEntity.id)
                            .update({
                          'wallet_balance': convertToDouble(
                                  amountController.text) +
                              convertToDouble(
                                  state.userDataEntity.walletBalance.toString())
                        }).then(
                          (value) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                        );
                      } catch (e) {
                        setState(() {
                          inProgress = false;
                        });
                      }
                    },
                  );
                }
                return ButtonCustom(
                  isDisabled: amountController.text.isEmpty,
                  margin: EdgeInsets.only(top: 70.h),
                  btnColor: primaryColor,
                  text: 'Recharge',
                  callback: () {},
                );
              },
            ),
            const SizedBox(height: 220),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const UpiPaymentScreen(),
            //       ),
            //     );
            //   },
            //   child: const Text('Recharge via UPI'),
            // ),
          ],
        ),
      ),
    );
  }

  double convertToDouble(String value) {
    return double.tryParse(value) ?? 1.0;
  }
}

// class ContainerCustom extends StatelessWidget {
//   final Widget child;

//   const ContainerCustom({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

class UpiPaymentScreen extends StatelessWidget {
  const UpiPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment'),
      ),
      body: const Center(
        child: Text('UPI Payment Screen'),
      ),
    );
  }
}
