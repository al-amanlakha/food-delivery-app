import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_images.dart';

class SmartImageProvider extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SmartImageProvider({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    Uri? uri;
    try {
      uri = Uri.parse(imageUrl);
    } catch (e) {
      debugPrint("Failed to parse URL: $e");
    }

    if (uri != null && uri.scheme == 'https') {
      return _buildNetworkImage();
    } else if (uri != null && uri.scheme == 'file' || _isLocalFilePath(imageUrl)) {
      return _buildFileImage();
    } else {
      // Assume it's a local asset or fallback case
      return _buildAssetImage();
    }
  }

  bool _isLocalFilePath(String path) {
    return File(path).existsSync(); // This checks if the file exists at the path
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      repeat: ImageRepeat.noRepeat,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
    );
  }

  Widget _buildFileImage() {
    return Image.file(
      File(imageUrl),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: SvgPicture.asset(
        AppImages.placeholderThumbnail,
        fit: BoxFit.contain,
        height: 30,
        width: 60,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: SvgPicture.asset(
        AppImages.placeholderThumbnail,
        fit: BoxFit.contain,
        height: 30,
        width: 60,
      ),
    );
  }
}
