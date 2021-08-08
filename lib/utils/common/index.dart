/// 判断是否网络
bool isNetWorkImg(String img) {
  return img.startsWith('http') || img.startsWith('https');
}

/// 判断是否资源图片[注意这个asset与assets跟项目资源文件地址有关]
bool isAssetsImg(String img) {
  return img.startsWith('asset') || img.startsWith('assets');
}
