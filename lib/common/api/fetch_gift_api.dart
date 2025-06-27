// @pragma('vm:entry-point')
// Future<void> onFetchCategoryWiseGiftIsolate(Map<String, dynamic> parameterMap) async {
//   FetchGiftApi.fetchGiftModel = null;
//
//   FetchGiftApi.fetchGiftModel = await FetchGiftApi.callApi(
//     token: parameterMap[ApiParams.token],
//     uid: parameterMap[ApiParams.uid],
//     giftCategoryId: parameterMap[ApiParams.giftCategoryId],
//   );
//
//   List<GiftData> gifts = FetchGiftApi.fetchGiftModel?.data ?? [];
//
//   SendPort sendPort = parameterMap[ApiParams.sendPort];
//
//   sendPort.send(gifts.map((e) => e.toJson()).toList());
//
//   Utils.showLog("Category Wise Gift List From Api => $gifts");
// }

// static Future<void> onGet({
//   required String token,
//   required String uid,
//   required String giftCategoryId,
// }) async {
//   Utils.showLog("Fetch Gift Init Call Success");
//
//   // var receivePort = ReceivePort();
//
//   // receivePort.listen(
//   //   (message) {
//   //     List<GiftData> gifts = (message as List).map((e) => GiftData.fromJson(e)).toList();
//   //
//   //     Map<String, List<GiftData?>> data = {};
//   //
//   //     Utils.showLog("********************** ${gifts}");
//   //     Utils.showLog("---------0----- => ${categoryWiseGift}");
//   //
//   //     data[giftCategoryId] = [];
//   //     Utils.showLog("---------1----- => ${categoryWiseGift}");
//   //
//   //     data[giftCategoryId] = gifts;
//   //
//   //     categoryWiseGift.assignAll(data);
//   //
//   //     Utils.showLog("Category Wise Gift Map => $categoryWiseGift");
//   //     test();
//   //     Utils.showLog("-------------- => ${categoryWiseGift["67dd25c6fb7221f997e7b6db"]?[0]?.image}");
//   //   },
//   // );
//   //
//   // Map<String, dynamic> data = {
//   //   ApiParams.sendPort: receivePort.sendPort,
//   //   ApiParams.token: token,
//   //   ApiParams.uid: uid,
//   //   ApiParams.giftCategoryId: giftCategoryId,
//   // };
//   //
//   // await FlutterIsolate.spawn(onFetchCategoryWiseGiftIsolate, data);
// }
