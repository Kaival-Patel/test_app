import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simform_kaival/src/modules/home/user_display_controller.dart';

//THIS IS BACKUP SCREEN IN CASE I COULDNT FINISH DRIFT INTEGRATION
class UserBackupScreen extends StatelessWidget {
  UserBackupScreen({super.key});
  var c = Get.put(UserListController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Simform Kaival Practical Test"),
        ),
        body: RefreshIndicator(
          onRefresh: () async => c.fetchUsers(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: c.obx(
                (state) => Column(
                      children: [
                        Obx(() {
                          if (!c.isLoadedFromInternet()) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Data loaded locally due to ${c.errorMessage()}",
                                        style: TextStyle(
                                            color: context.theme.disabledColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            key: Key("size"),
                          );
                        }),
                        FadeInUp(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      state[index].picture.medium)),
                              title: Text(state[index].name.first),
                              subtitle: Text(state[index].email),
                            ),
                            itemCount: state!.length,
                          ),
                        ),
                      ],
                    ),
                onEmpty: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height * 0.5),
                  child: Center(
                      child: Text("Data is Empty (No local data found)")),
                ),
                onError: (e) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: context.height * 0.5),
                    child: Center(child: Text("${e}"))),
                onLoading: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height * 0.5),
                  child: Center(child: CircularProgressIndicator()),
                )),
          ),
        ),
      ),
    );
  }
}
