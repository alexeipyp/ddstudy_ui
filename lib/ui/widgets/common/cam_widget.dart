import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CamWidget extends StatefulWidget {
  final Function(File) onFile;
  const CamWidget({
    Key? key,
    required this.onFile,
  }) : super(key: key);

  @override
  State<CamWidget> createState() => CamWidgetState();
}

class CamWidgetState extends State<CamWidget> {
  CameraController? controller;
  List<CameraDescription> cameras = <CameraDescription>[];
  bool isFrontCamAvailable = false;
  bool isMainCamChosen = true;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    cameras = await availableCameras();
    if (cameras.length > 1) {
      if (cameras[1].lensDirection == CameraLensDirection.front) {
        isFrontCamAvailable = true;
      }
    }
    await initCamera(cameras[0]);
  }

  Future initCamera(CameraDescription camera) async {
    controller = CameraController(camera, ResolutionPreset.high);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void changeCamera() async {
    initCamera(cameras[isMainCamChosen ? 1 : 0]);
    setState(() {
      isMainCamChosen = !isMainCamChosen;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return Center(
        child: Text(
          "Camera initialize",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .merge(const TextStyle(color: Colors.white)),
        ),
      );
    }

    var camera = controller!.value;

    return LayoutBuilder(builder: ((context, constraint) {
      var scale = (min(constraint.maxWidth, constraint.maxHeight) /
              max(constraint.maxHeight, constraint.maxWidth)) *
          camera.aspectRatio;

      if (scale < 1) {
        scale = 1 / scale;
      }

      return Scaffold(
        body: Stack(
          children: [
            Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(
                  controller!,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      color: Colors.grey[400]!.withAlpha(150),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 60,
                    height: 60,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.camera),
                      color: Colors.white,
                      iconSize: 54,
                      onPressed: () async {
                        var file = await controller!.takePicture();
                        widget.onFile(File(file.path));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: isFrontCamAvailable
            ? FloatingActionButton(
                onPressed: changeCamera,
                child: const Icon(Icons.change_circle_outlined),
              )
            : const SizedBox.shrink(),
      );
    }));
  }
}
