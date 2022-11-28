import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../util/extensions.dart';

import '../../../util/app_validation.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';

class CommonImageNetwork extends StatelessWidget {
  final String? url;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget? errorWidget;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? loadingSize;

  const CommonImageNetwork({
    required this.url,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.width,
    this.height,
    this.loadingSize,
  });

  Widget buildPlaceHolder() {
    return Center(
      child: Container(
        width: loadingSize ?? width ?? 20.0.sp,
        height: loadingSize ?? height ?? 20.0.sp,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.ic_placeholder),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 20.0.sp,
            height: 20.0.sp,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isNullEmpty(url)
        ? const Icon(Icons.error)
        : CachedNetworkImage(
      memCacheWidth: (width ?? 0.0) > 0.0 ? ((width?.toInt() ?? 0) + 150) : 100,
      width: width,
      height: height,
      imageUrl: url ?? '',
      placeholder: placeholder ?? (context, url) => buildPlaceHolder(),
      errorWidget: (context, url, error) {
        return errorWidget ?? buildPlaceHolder();
      },
      fit: fit ?? BoxFit.contain,
      cacheManager: CacheManager(Config('ImageCacheKey', stalePeriod: const Duration(days: 100))),
    );
  }
}
