import 'dart:async';
import 'dart:math';

import 'package:fl_clash/common/color.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/activate_box.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  MobileScannerController? controller;
  StreamSubscription<Object?>? _subscription;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initScanner();
  }

  Future<void> _initScanner() async {
    try {
      controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        formats: const [BarcodeFormat.qrCode],
      );
      _subscription = controller?.barcodes.listen(_handleBarcode);
      await controller?.start();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Failed to initialize scanner: $e');
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    if (!mounted || barcodeCapture.barcodes.isEmpty) return;
    final barcode = barcodeCapture.barcodes.first;
    if (barcode.type == BarcodeType.url) {
      Navigator.pop<String>(context, barcode.rawValue);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (controller == null) return;

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription?.cancel();
        _subscription = controller?.barcodes.listen(_handleBarcode);
        controller?.start();
      case AppLifecycleState.inactive:
        _subscription?.cancel();
        _subscription = null;
        controller?.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double sideLength = min(
      400,
      MediaQuery.of(context).size.width * 0.67,
    );
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: sideLength,
      height: sideLength,
    );

    if (!_isInitialized || controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: MobileScanner(
              controller: controller!,
              scanWindow: scanWindow,
            ),
          ),
          CustomPaint(painter: ScannerOverlay(scanWindow: scanWindow)),
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              style: IconButton.styleFrom(
                iconSize: 32,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
            actions: [
              ValueListenableBuilder<MobileScannerState>(
                valueListenable: controller!,
                builder: (context, state, _) {
                  var icon = const Icon(Icons.flash_off);
                  var backgroundColor = Colors.black12;
                  switch (state.torchState) {
                    case TorchState.off:
                      icon = const Icon(Icons.flash_off);
                      backgroundColor = Colors.black12;
                    case TorchState.on:
                      icon = const Icon(Icons.flash_on);
                      backgroundColor = Colors.orange;
                    case TorchState.unavailable:
                      icon = const Icon(Icons.flash_off);
                      backgroundColor = Colors.transparent;
                    case TorchState.auto:
                      icon = const Icon(Icons.flash_auto);
                      backgroundColor = Colors.orange;
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ActivateBox(
                      active: state.torchState != TorchState.unavailable,
                      child: IconButton(
                        color: Colors.white,
                        icon: icon,
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: backgroundColor,
                        ),
                        onPressed: () => controller?.toggleTorch(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            alignment: Alignment.bottomCenter,
            child: IconButton(
              color: Colors.white,
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
              padding: const EdgeInsets.all(16),
              iconSize: 32.0,
              onPressed: globalState.container
                  .read(profilesActionProvider.notifier)
                  .addProfileFormQrCode,
              icon: const Icon(Icons.photo_camera_back),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _subscription = null;
    controller?.dispose();
    controller = null;
    super.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({required this.scanWindow, this.borderRadius = 12.0});

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanWindow, Radius.circular(borderRadius)),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final border = RRect.fromRectAndRadius(
      scanWindow,
      Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(border, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
