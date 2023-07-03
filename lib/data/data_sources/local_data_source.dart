import '../network/error_handler.dart';
import '../response/responses.dart';

const cacheHomeKey = "CACHE_HOME_KEY";
const cacheHomeInterval = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeDataToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      //return response from cache
      return cachedItem.data;
    } else {
      //return error cache isn't there or isn't valid
      throw ErrorHandler.handler(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(data: homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem({required this.data});
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillisec) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool isValid = (currentTime - cacheTime) <= expirationTimeInMillisec;
    return isValid;
  }
}
