import 'dart:developer';
import 'dart:io';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svga/flutter_svga.dart';
import 'package:tingle/custom/widget/custum_frame_image.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileImageWidget extends StatelessWidget {
  const PreviewProfileImageWidget({super.key, this.image, this.fit, this.isBanned, this.isShowPlaceHolder});

  final String? image;
  final BoxFit? fit;
  final bool? isBanned;
  final bool? isShowPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return (image != null && image != "")
        ? image!.startsWith("https")
            ? CachedNetworkImage(
                imageUrl: image ?? "",
                fit: fit ?? BoxFit.cover,
                errorWidget: (context, url, error) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                placeholder: (context, url) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                memCacheWidth: 120,
                memCacheHeight: 120,
                maxWidthDiskCache: 120,
                maxHeightDiskCache: 120,
              )
            : Database.networkImage(Api.baseUrl + image!) != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: (Api.baseUrl + (image ?? "")),
                        fit: fit ?? BoxFit.cover,
                        errorWidget: (context, url, error) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                        placeholder: (context, url) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                        memCacheWidth: 120,
                        memCacheHeight: 120,
                        maxWidthDiskCache: 120,
                        maxHeightDiskCache: 120,
                      ),
                      Visibility(
                        visible: isBanned ?? false,
                        child: BlurryContainer(
                          blur: 3,
                          color: AppColor.black.withValues(alpha: 0.2),
                          child: Offstage(),
                        ),
                      )
                    ],
                  )
                : FutureBuilder(
                    future: _onCheckImage(Api.baseUrl + image!),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder();
                      } else if (snapshot.hasError) {
                        return isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder();
                      } else {
                        if (snapshot.data == true) {
                          Database.onSetNetworkImage(Api.baseUrl + image!);
                          return CachedNetworkImage(
                            imageUrl: Api.baseUrl + image!,
                            fit: fit ?? BoxFit.cover,
                            placeholder: (context, url) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                            errorWidget: (context, url, error) => isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder(),
                            memCacheWidth: 120,
                            memCacheHeight: 120,
                            maxWidthDiskCache: 120,
                            maxHeightDiskCache: 120,
                          );
                        } else {
                          return isShowPlaceHolder == false ? Offstage() : ProfileImagePlaceHolder();
                        }
                      }
                    },
                  )
        : ProfileImagePlaceHolder();
  }
}

class ProfileImagePlaceHolder extends StatelessWidget {
  const ProfileImagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppAssets.icProfilePlaceHolder, fit: BoxFit.cover);
  }
}

class FrameImagePlaceHolder extends StatelessWidget {
  const FrameImagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppAssets.ic_frame_icon, fit: BoxFit.cover);
  }
}
//****************************************************************************************************************************************

class PreviewPostImageWidget extends StatelessWidget {
  const PreviewPostImageWidget({super.key, this.image, this.fit, this.isBanned, this.size, this.isShowPlaceHolder});

  final String? image;
  final BoxFit? fit;
  final bool? isBanned;
  final double? size;
  final bool? isShowPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return (image != null && image != "")
        ? image!.startsWith("https")
            ? Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: image != null ? ((image ?? "")) : "",
                    fit: fit,
                    errorWidget: (context, url, error) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                    placeholder: (context, url) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                  ),
                  Visibility(
                    visible: isBanned ?? false,
                    child: BlurryContainer(
                      blur: 10,
                      color: AppColor.black.withValues(alpha: 0.3),
                      child: Offstage(),
                    ),
                  )
                ],
              )
            : isLocalFile(image ?? "")
                ? buildImage(image ?? "")
                : Database.networkImage(Api.baseUrl + image!) != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: image != null ? (Api.baseUrl + (image ?? "")) : "",
                            fit: fit,
                            errorWidget: (context, url, error) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                            placeholder: (context, url) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                          ),
                          Visibility(
                            visible: isBanned ?? false,
                            child: BlurryContainer(
                              blur: 10,
                              color: AppColor.black.withValues(alpha: 0.3),
                              child: Offstage(),
                            ),
                          )
                        ],
                      )
                    : FutureBuilder(
                        future: _onCheckImage(Api.baseUrl + image!),
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder);
                          } else if (snapshot.hasError) {
                            return PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder);
                          } else {
                            if (snapshot.data == true) {
                              Database.onSetNetworkImage(Api.baseUrl + image!);
                              return CachedNetworkImage(
                                imageUrl: Api.baseUrl + image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                                errorWidget: (context, url, error) => PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder),
                              );
                            } else {
                              return PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder);
                            }
                          }
                        },
                      )
        : PostImagePlaceHolder(size: size, isShowPlaceHolder: isShowPlaceHolder);
  }
}

class PostImagePlaceHolder extends StatelessWidget {
  const PostImagePlaceHolder({super.key, this.size, this.isShowPlaceHolder});

  final double? size;
  final bool? isShowPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return isShowPlaceHolder == false
        ? Offstage()
        : Center(
            child: Image.asset(
              AppAssets.icImagePlaceHolder,
              height: size ?? 100,
              width: size ?? 100,
            ),
          );
  }
}

//****************************************************************************************************************************************

Future<bool> _onCheckImage(String image) async {
  try {
    final response = await http.head(Uri.parse(image));

    return response.statusCode == 200;
  } catch (e) {
    Utils.showLog('Check Profile Image Filed !! => $e');
    return false;
  }
}

//****************************************************************************************************************************************

class PreviewGiftWidget extends StatelessWidget {
  const PreviewGiftWidget({super.key, this.url, this.type});

  final String? url;
  final int? type;

  @override
  Widget build(BuildContext context) {
    Utils.showLog("Gift Type => $type **** Gift Url => $url");
    return url != null && type != null
        ? type == 3
            ? SVGAEasyPlayer(
                resUrl: Api.baseUrl + (url ?? ""),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: (Api.baseUrl + (url ?? "")),
                errorWidget: (context, url, error) => Offstage(),
              )
        : Offstage();
  }
}

//****************************************************************************************************************************************

class PreviewLevelImageWidget extends StatelessWidget {
  const PreviewLevelImageWidget({super.key, this.image, this.fit});

  final String? image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return (image != null && image != "")
        ? image!.startsWith("https")
            ? CachedNetworkImage(
                imageUrl: image ?? "",
                fit: fit ?? BoxFit.cover,
                errorWidget: (context, url, error) => Offstage(),
                placeholder: (context, url) => Offstage(),
              )
            : Database.networkImage(Api.baseUrl + image!) != null
                ? CachedNetworkImage(
                    imageUrl: (Api.baseUrl + (image ?? "")),
                    fit: fit ?? BoxFit.cover,
                    errorWidget: (context, url, error) => Offstage(),
                    placeholder: (context, url) => Offstage(),
                  )
                : FutureBuilder(
                    future: _onCheckImage(Api.baseUrl + image!),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Offstage();
                      } else if (snapshot.hasError) {
                        return Offstage();
                      } else {
                        if (snapshot.data == true) {
                          Database.onSetNetworkImage(Api.baseUrl + image!);
                          return CachedNetworkImage(
                            imageUrl: Api.baseUrl + image!,
                            fit: fit ?? BoxFit.cover,
                            placeholder: (context, url) => Offstage(),
                            errorWidget: (context, url, error) => Offstage(),
                          );
                        } else {
                          return Offstage();
                        }
                      }
                    },
                  )
        : Offstage();
  }
}

//****************************************************************************************************************************************
bool isFileImage(String path) {
  try {
    return path.isNotEmpty && !path.startsWith('http') && (path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.png') || path.endsWith('.gif') || path.endsWith('.bmp') || path.endsWith('.webp'));
  } catch (e) {
    print("Error checking file image: $e");
    return false;
  }
}

bool isLocalFile(String path) {
  try {
    final file = File(path);
    return file.isAbsolute && file.existsSync();
  } catch (e) {
    print("Error checking local file: $e");
    return false;
  }
}

Widget buildImage(String imagePath) {
  try {
    log("Image Local Path => $imagePath");
    if (isFileImage(imagePath)) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      return Image.network(imagePath);
    } else {
      return Icon(Icons.broken_image);
    }
  } catch (e) {
    print("Error displaying image: $e");
    return Icon(Icons.error);
  }
}
//****************************************************************************************************************************************

class PreviewCountryFlagIcon extends StatelessWidget {
  const PreviewCountryFlagIcon({super.key, this.flag, this.networkFlagSize, this.localFlagSize});

  final String? flag;
  final double? networkFlagSize;
  final double? localFlagSize;

  @override
  Widget build(BuildContext context) {
    return (flag != null && flag != "")
        ? (flag?.startsWith("https") ?? false)
            ? SizedBox(
                height: networkFlagSize ?? 16,
                width: networkFlagSize ?? 16,
                child: CachedNetworkImage(
                  imageUrl: flag ?? "",
                  height: networkFlagSize,
                  width: networkFlagSize,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Offstage(),
                ),
              )
            : Text(
                flag ?? Utils.defaultCountryFlag,
                style: AppFontStyle.styleW700(AppColor.white, localFlagSize ?? networkFlagSize ?? 16),
              )
        : Text(
            Utils.defaultCountryFlag,
            style: AppFontStyle.styleW700(AppColor.white, localFlagSize ?? networkFlagSize ?? 16),
          );
  }
}

//****************************************************************************************************************************************

class PreviewProfileImageWithFrameWidget extends StatelessWidget {
  const PreviewProfileImageWithFrameWidget({
    super.key,
    this.image,
    this.fit,
    this.isBanned,
    this.frame,
    this.type,
    this.margin,
  });

  final String? image;
  final BoxFit? fit;
  final bool? isBanned;
  final String? frame;
  final int? type;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Utils.showLog("Preview Profile Image With Frame Widget => Frame Type => $type Frame => $frame");

    final isFrameAvailable = (type != null && (frame?.trim().isNotEmpty ?? false));
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: isFrameAvailable ? margin : EdgeInsets.zero,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: PreviewProfileImageWidget(image: image, fit: fit, isBanned: isBanned),
          ),
          Visibility(
            visible: isFrameAvailable,
            child: type == 3
                ? SVGAEasyPlayer(
                    resUrl: Api.baseUrl + (frame ?? ""),
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: (Api.baseUrl + (frame ?? "")),
                    errorWidget: (context, url, error) => Offstage(),
                  ),
          ),
        ],
      ),
    );
  }
}

class PreviewWealthLevelImage extends StatelessWidget {
  const PreviewWealthLevelImage({super.key, this.image, this.height, this.width});

  final String? image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return (image?.trim().isEmpty ?? true)
        ? Offstage()
        : SizedBox(
            height: height ?? 20,
            width: width ?? 40,
            child: CachedNetworkImage(
              imageUrl: Api.baseUrl + (image ?? ""),
              height: height ?? 20,
              width: width ?? 40,
              errorWidget: (context, url, error) => Offstage(),
            ),
          );
  }
}

//****************************************************************************************************************************************

class PreviewThemeFrameRideWidget extends StatelessWidget {
  const PreviewThemeFrameRideWidget({super.key, this.url, this.type});

  final String? url;
  final int? type;

  @override
  Widget build(BuildContext context) {
    Utils.showLog("Gift Type => $type **** Gift Url => $url");
    return url != null && type != null
        ? type == 3
            ? SVGAEasyPlayer(
                resUrl: Api.baseUrl + (url ?? ""),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: (Api.baseUrl + (url ?? "")),
                errorWidget: (context, url, error) => Offstage(),
              )
        : Offstage();
  }
}

//****************************************************************************************************************************************

class PreviewProfileWithSVGAWidget extends StatelessWidget {
  PreviewProfileWithSVGAWidget({
    super.key,
    this.image,
    this.fit,
    this.isBanned,
    this.height,
    this.width,
    this.frame,
    this.itemType,
  });
  final double? height;
  final double? width;
  final String? image;
  final String? itemType;
  final BoxFit? fit;
  final bool? isBanned;

  dynamic frame;

  @override
  Widget build(BuildContext context) {
    return (image != null && image != "")
        ? image!.startsWith("https")
            ? Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: image ?? "",
                    fit: fit ?? BoxFit.cover,
                    height: height,
                    width: width,
                    errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                    placeholder: (context, url) => ProfileImagePlaceHolder(),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                      );
                    },
                  ),
                  frame == null
                      ? Container()
                      : CustomSVGAFrameWidget(
                          itemType: itemType,
                          imagePath: frame!.image ?? "",
                          type: frame!.type ?? 1,
                          framePath: "",
                          width: width!,
                          height: height!,
                        )
                ],
              )
            : Database.networkImage(Api.baseUrl + image!) != null
                ? Stack(
                    fit: StackFit.expand,
                    // alignment: Alignment.center,
                    children: [
                      itemType != ApiParams.FRAME && itemType != ApiParams.frame
                          ? SizedBox()
                          : CachedNetworkImage(
                              imageUrl: (Api.baseUrl + (image ?? "")),
                              fit: fit ?? BoxFit.cover,
                              height: height,
                              width: width,
                              errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                              placeholder: (context, url) => ProfileImagePlaceHolder(),
                              imageBuilder: (context, imageProvider) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                                  ),
                                );
                              },
                            ),
                      frame == null
                          ? 0.height
                          : CustomSVGAFrameWidget(
                              itemType: itemType,
                              imagePath: frame!.image ?? "",
                              type: frame!.type ?? 1,
                              framePath: "",
                              height: height!,
                              width: width!,
                            ),
                      Visibility(
                        visible: isBanned ?? false,
                        child: BlurryContainer(
                          blur: 3,
                          color: AppColor.black.withValues(alpha: 0.2),
                          child: Offstage(),
                        ),
                      )
                    ],
                  )
                : FutureBuilder(
                    future: _onCheckImage(Api.baseUrl + image!),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ProfileImagePlaceHolder();
                      } else if (snapshot.hasError) {
                        return ProfileImagePlaceHolder();
                      } else {
                        if (snapshot.data == true) {
                          Database.onSetNetworkImage(Api.baseUrl + image!);
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: Api.baseUrl + image!,
                                fit: fit ?? BoxFit.cover,
                                height: height,
                                width: width,
                                placeholder: (context, url) => ProfileImagePlaceHolder(),
                                errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                                  );
                                },
                              ),
                              frame == null
                                  ? 0.height
                                  : CustomSVGAFrameWidget(
                                      imagePath: frame!.image ?? "",
                                      type: frame!.type ?? 1,
                                      framePath: "",
                                      itemType: itemType,
                                      height: height!,
                                      width: width!,
                                    )
                            ],
                          );
                        } else {
                          return ProfileImagePlaceHolder();
                        }
                      }
                    },
                  )
        : CustomPreviewNetworkWithFrameWidget(
            image: Api.baseUrl + (image ?? ""),
            frameImage: frame,
            itemType: itemType,
            height: height,
            width: width,
          );
  }
}

//****************************************************************************************************************************************
class CustomPreviewNetworkWithFrameWidget extends StatelessWidget {
  const CustomPreviewNetworkWithFrameWidget({super.key, this.image, this.fit, this.frameImage, this.height, this.width, this.itemType});
  final double? height;
  final double? width;
  final String? image;
  final String? itemType;
  final BoxFit? fit;
  final dynamic frameImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: image ?? "",
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, url, error) => const Offstage(),
          placeholder: (context, url) => const Offstage(),
          imageBuilder: (context, imageProvider) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
            );
          },
        ),
        frameImage == null ? 0.height : CustomSVGAFrameWidget(imagePath: frameImage!.image ?? "", type: frameImage!.type ?? 1, framePath: frameImage!.svgaImage, height: height!, width: width!, itemType: itemType)
      ],
    );
  }
}

class PreviewProfileWithFrameWidget extends StatelessWidget {
  PreviewProfileWithFrameWidget({
    super.key,
    this.image,
    this.fit,
    this.isBanned,
    this.height,
    this.width,
    this.frame,
    this.itemType,
  });
  final double? height;
  final double? width;
  final String? image;
  final String? itemType;
  final BoxFit? fit;
  final bool? isBanned;

  dynamic frame;

  @override
  Widget build(BuildContext context) {
    return (image != null && image != "")
        ? image!.startsWith("https")
            ? Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: image ?? "",
                    fit: fit ?? BoxFit.cover,
                    height: height,
                    width: width,
                    errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                    placeholder: (context, url) => ProfileImagePlaceHolder(),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                      );
                    },
                  ),
                  frame == null
                      ? Container()
                      : CustomSVGAFrameWidget(
                          itemType: itemType,
                          imagePath: frame!.image ?? "",
                          type: frame!.type ?? 1,
                          framePath: frame!.svgaImage ?? "",
                          width: width!,
                          height: height!,
                        )
                ],
              )
            : Database.networkImage(Api.baseUrl + image!) != null
                ? Stack(
                    fit: StackFit.expand,
                    // alignment: Alignment.center,
                    children: [
                      itemType != ApiParams.FRAME && itemType != ApiParams.frame
                          ? SizedBox()
                          : CachedNetworkImage(
                              imageUrl: (Api.baseUrl + (image ?? "")),
                              fit: fit ?? BoxFit.cover,
                              height: height,
                              width: width,
                              errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                              placeholder: (context, url) => ProfileImagePlaceHolder(),
                              imageBuilder: (context, imageProvider) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                                  ),
                                );
                              },
                            ),
                      frame == null
                          ? 0.height
                          : CustomSVGAFrameWidget(
                              itemType: itemType,
                              imagePath: frame!.image ?? "",
                              type: frame!.type ?? 1,
                              framePath: frame!.svgaImage ?? "",
                              height: height!,
                              width: width!,
                            ),
                      Visibility(
                        visible: isBanned ?? false,
                        child: BlurryContainer(
                          blur: 3,
                          color: AppColor.black.withValues(alpha: 0.2),
                          child: Offstage(),
                        ),
                      )
                    ],
                  )
                : FutureBuilder(
                    future: _onCheckImage(Api.baseUrl + image!),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ProfileImagePlaceHolder();
                      } else if (snapshot.hasError) {
                        return ProfileImagePlaceHolder();
                      } else {
                        if (snapshot.data == true) {
                          Database.onSetNetworkImage(Api.baseUrl + image!);
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: Api.baseUrl + image!,
                                fit: fit ?? BoxFit.cover,
                                height: height,
                                width: width,
                                placeholder: (context, url) => ProfileImagePlaceHolder(),
                                errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover)),
                                  );
                                },
                              ),
                              frame == null
                                  ? 0.height
                                  : CustomSVGAFrameWidget(
                                      imagePath: frame!.image ?? "",
                                      type: frame!.type ?? 1,
                                      framePath: frame!.svgaImage ?? "",
                                      itemType: itemType,
                                      height: height!,
                                      width: width!,
                                    )
                            ],
                          );
                        } else {
                          return ProfileImagePlaceHolder();
                        }
                      }
                    },
                  )
        : CustomPreviewNetworkWithFrameWidget(
            image: Api.baseUrl + (image ?? ""),
            frameImage: frame,
            itemType: itemType,
            height: height,
            width: width,
          );
  }
}
