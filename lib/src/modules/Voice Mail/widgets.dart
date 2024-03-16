import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/voicemail_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/repo.dart';

class VoiceMailBody extends StatelessWidget {
  const VoiceMailBody({super.key});

  @override
  Widget build(BuildContext context) {
    VoiceMailBloc voiceMailController = Get.find();
    MyTelRepo repo = MyTelRepo();

    return GetBuilder(
        init: voiceMailController,
        builder: (context) {
          return ListView.builder(
              itemCount: repo.voiceMails?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.CHAT);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: Get.height * .015, top: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //avatar
                            GestureDetector(
                              onTap: () async {
                                voiceMailController.voiceMail =
                                    repo.voiceMails!.data![index];
                                await voiceMailController.handlePlayVoiceMail();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: hintColor.withOpacity(.3)),
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                    child: Obx(
                                  () => repo.voiceMails?.data?[index]
                                              .downloading?.value ??
                                          false
                                      ? CircularProgressIndicator()
                                      : Icon(
                                          repo.voiceMails?.data?[index].playing!
                                                      .value ??
                                                  false
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: repo.voiceMails?.data?[index]
                                                          .messageStatus !=
                                                      null &&
                                                  repo.voiceMails?.data?[index]
                                                          .messageStatus ==
                                                      "saved"
                                              ? muteColor
                                              : Colors.blueAccent,
                                        ),
                                )),
                              ),
                            ),
                            spX(10),
                            //name & last message & time
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * .5,
                                        child: Text(
                                          repo.voiceMails?.data?[index]
                                                  .callerIdName ??
                                              "Unknown",
                                          style: textSmall.copyWith(
                                              fontWeight: repo
                                                              .voiceMails
                                                              ?.data?[index]
                                                              .messageStatus !=
                                                          null &&
                                                      repo
                                                              .voiceMails
                                                              ?.data?[index]
                                                              .messageStatus ==
                                                          "saved"
                                                  ? null
                                                  : FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            repo.voiceMails!.data![index]
                                                        .createdDate!
                                                        .difference(
                                                            DateTime.now())
                                                        .inDays <
                                                    -2
                                                ? "${-repo.voiceMails!.data![index].createdDate!.difference(DateTime.now()).inDays} days ago"
                                                : repo.voiceMails!.data![index]
                                                            .createdDate!
                                                            .difference(
                                                                DateTime.now())
                                                            .inDays ==
                                                        0
                                                    ? "${repo.voiceMails!.data![index].createdDate!.hour}:${repo.voiceMails!.data![index].createdDate!.minute}"
                                                    : "yesterday",
                                            style: textSmall.copyWith(
                                                color: muteColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  spY(5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: Get.width * .5,
                                          // width: Get.width,
                                          child: Obx(
                                            () => Text(
                                              voiceMailController
                                                      .remainedPlayerTime
                                                      .value
                                                      .isNotEmpty
                                                  ? voiceMailController
                                                      .remainedPlayerTime.value
                                                  : repo
                                                          .voiceMails
                                                          ?.data?[index]
                                                          .timeLengthLabel ??
                                                      "00:00",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: textSmall.copyWith(
                                                  color: hintColor),
                                            ),
                                          )),
                                      Icon(
                                        repo.voiceMails?.data?[index]
                                                        .messageStatus !=
                                                    null &&
                                                repo.voiceMails?.data?[index]
                                                        .messageStatus ==
                                                    "saved"
                                            ? Icons.done_all
                                            : Icons.done,
                                        color: Colors.blueAccent,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //dividers
                        Container(
                          height: 1,
                          width: Get.width * .7,
                          margin: EdgeInsets.only(
                            top: Get.height * .01,
                            // bottom: 5,
                            left: Get.width * .09,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5, color: hintBackGroundColor)),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
