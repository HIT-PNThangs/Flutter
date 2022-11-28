class Tiktok {
  int? statusCode;
  Body? body;
  dynamic errMsg;

  Tiktok({this.statusCode, this.body, this.errMsg});

  Tiktok.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    errMsg = json['errMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    data['errMsg'] = errMsg;
    return data;
  }
}

class Body {
  PageState? pageState;
  List<ItemListData>? itemListData;
  String? hasMore;
  String? maxCursor;
  String? minCursor;

  Body({this.pageState, this.itemListData, this.hasMore, this.maxCursor, this.minCursor});

  Body.fromJson(Map<String, dynamic> json) {
    pageState = json['pageState'] != null ? PageState.fromJson(json['pageState']) : null;
    if (json['itemListData'] != null) {
      itemListData = <ItemListData>[];
      json['itemListData'].forEach((v) {
        itemListData!.add(ItemListData.fromJson(v));
      });
    }

    hasMore = json['hasMore'].toString();
    maxCursor = json['maxCursor'];
    minCursor = json['minCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pageState != null) {
      data['pageState'] = pageState!.toJson();
    }
    if (itemListData != null) {
      data['itemListData'] = itemListData!.map((v) => v.toJson()).toList();
    }

    data['hasMore'] = hasMore;
    data['maxCursor'] = maxCursor;
    data['minCursor'] = minCursor;
    return data;
  }
}

class PageState {
  int? regionAppId;
  String? os;
  String? region;
  String? baseURL;
  String? appType;
  String? fullUrl;

  PageState({
    this.regionAppId,
    this.os,
    this.region,
    this.baseURL,
    this.appType,
    this.fullUrl,
  });

  PageState.fromJson(Map<String, dynamic> json) {
    regionAppId = json['regionAppId'];
    os = json['os'];
    region = json['region'];
    baseURL = json['baseURL'];
    appType = json['appType'];
    fullUrl = json['fullUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionAppId'] = regionAppId;
    data['os'] = os;
    data['region'] = region;
    data['baseURL'] = baseURL;
    data['appType'] = appType;
    data['fullUrl'] = fullUrl;
    return data;
  }
}

class ItemListData {
  ItemInfos? itemInfos;
  AuthorInfos? authorInfos;
  MusicInfos? musicInfos;
  List<ChallengeInfoList>? challengeInfoList;
  String? duetInfo;
  List<TextExtra>? textExtra;
  AuthorStats? authorStats;

  ItemListData({
    this.itemInfos,
    this.authorInfos,
    this.musicInfos,
    this.challengeInfoList,
    this.duetInfo,
    this.textExtra,
    this.authorStats,
  });

  ItemListData.fromJson(Map<String, dynamic> json) {
    itemInfos = json['itemInfos'] != null ? ItemInfos.fromJson(json['itemInfos']) : null;
    authorInfos = json['authorInfos'] != null ? AuthorInfos.fromJson(json['authorInfos']) : null;
    musicInfos = json['musicInfos'] != null ? MusicInfos.fromJson(json['musicInfos']) : null;
    if (json['challengeInfoList'] != null) {
      challengeInfoList = <ChallengeInfoList>[];
      json['challengeInfoList'].forEach((v) {
        challengeInfoList!.add(ChallengeInfoList.fromJson(v));
      });
    }
    duetInfo = json['duetInfo'];
    if (json['textExtra'] != null) {
      textExtra = <TextExtra>[];
      json['textExtra'].forEach((v) {
        textExtra!.add(TextExtra.fromJson(v));
      });
    }
    authorStats = json['authorStats'] != null ? AuthorStats.fromJson(json['authorStats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (itemInfos != null) {
      data['itemInfos'] = itemInfos!.toJson();
    }
    if (authorInfos != null) {
      data['authorInfos'] = authorInfos!.toJson();
    }
    if (musicInfos != null) {
      data['musicInfos'] = musicInfos!.toJson();
    }
    if (challengeInfoList != null) {
      data['challengeInfoList'] = challengeInfoList!.map((v) => v.toJson()).toList();
    }
    data['duetInfo'] = duetInfo;
    if (textExtra != null) {
      data['textExtra'] = textExtra!.map((v) => v.toJson()).toList();
    }
    if (authorStats != null) {
      data['authorStats'] = authorStats!.toJson();
    }
    return data;
  }
}

class ItemInfos {
  String? id;
  String? text;
  String? createTime;
  String? authorId;
  String? musicId;
  List<String>? covers;
  List<String>? coversOrigin;
  List<String>? coversDynamic;
  Video? video;
  int? diggCount;
  int? shareCount;
  int? playCount;
  int? commentCount;
  bool? isOriginal;
  bool? isOfficial;
  bool? isActivityItem;
  List<dynamic>? warnInfo;

  ItemInfos(
      {this.id,
      this.text,
      this.createTime,
      this.authorId,
      this.musicId,
      this.covers,
      this.coversOrigin,
      this.coversDynamic,
      this.video,
      this.diggCount,
      this.shareCount,
      this.playCount,
      this.commentCount,
      this.isOriginal,
      this.isOfficial,
      this.isActivityItem,
      this.warnInfo});

  ItemInfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createTime = json['createTime'];
    authorId = json['authorId'];
    musicId = json['musicId'];
    covers = json['covers'].cast<String>();
    coversOrigin = json['coversOrigin'].cast<String>();
    coversDynamic = json['coversDynamic'].cast<String>();
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
    diggCount = json['diggCount'];
    shareCount = json['shareCount'];
    playCount = json['playCount'];
    commentCount = json['commentCount'];
    isOriginal = json['isOriginal'];
    isOfficial = json['isOfficial'];
    isActivityItem = json['isActivityItem'];
    if (json['warnInfo'] != null) {
      warnInfo = <dynamic>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['createTime'] = createTime;
    data['authorId'] = authorId;
    data['musicId'] = musicId;
    data['covers'] = covers;
    data['coversOrigin'] = coversOrigin;
    data['coversDynamic'] = coversDynamic;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    data['diggCount'] = diggCount;
    data['shareCount'] = shareCount;
    data['playCount'] = playCount;
    data['commentCount'] = commentCount;
    data['isOriginal'] = isOriginal;
    data['isOfficial'] = isOfficial;
    data['isActivityItem'] = isActivityItem;
    return data;
  }
}

class Video {
  List<String>? urls;
  VideoMeta? videoMeta;

  Video({this.urls, this.videoMeta});

  Video.fromJson(Map<String, dynamic> json) {
    urls = json['urls'].cast<String>();
    videoMeta = json['videoMeta'] != null ? VideoMeta.fromJson(json['videoMeta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['urls'] = urls;
    if (videoMeta != null) {
      data['videoMeta'] = videoMeta!.toJson();
    }
    return data;
  }
}

class VideoMeta {
  int? width;
  int? height;
  int? ratio;
  int? duration;

  VideoMeta({
    this.width,
    this.height,
    this.ratio,
    this.duration,
  });

  VideoMeta.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    ratio = json['ratio'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['ratio'] = ratio;
    data['duration'] = duration;
    return data;
  }
}

class AuthorInfos {
  String? secUid;
  String? userId;
  String? uniqueId;
  String? nickName;
  String? signature;
  bool? verified;
  List<String>? covers;
  List<String>? coversMedium;
  List<String>? coversLarger;
  bool? isSecret;

  AuthorInfos({
    this.secUid,
    this.userId,
    this.uniqueId,
    this.nickName,
    this.signature,
    this.verified,
    this.covers,
    this.coversMedium,
    this.coversLarger,
    this.isSecret,
  });

  AuthorInfos.fromJson(Map<String, dynamic> json) {
    secUid = json['secUid'];
    userId = json['userId'];
    uniqueId = json['uniqueId'];
    nickName = json['nickName'];
    signature = json['signature'];
    verified = json['verified'];
    covers = json['covers'].cast<String>();
    coversMedium = json['coversMedium'].cast<String>();
    coversLarger = json['coversLarger'].cast<String>();
    isSecret = json['isSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secUid'] = secUid;
    data['userId'] = userId;
    data['uniqueId'] = uniqueId;
    data['nickName'] = nickName;
    data['signature'] = signature;
    data['verified'] = verified;
    data['covers'] = covers;
    data['coversMedium'] = coversMedium;
    data['coversLarger'] = coversLarger;
    data['isSecret'] = isSecret;
    return data;
  }
}

class MusicInfos {
  String? musicId;
  String? musicName;
  String? authorName;
  String? original;
  List<String>? playUrl;
  List<String>? covers;
  List<String>? coversMedium;
  List<String>? coversLarger;

  MusicInfos({
    this.musicId,
    this.musicName,
    this.authorName,
    this.original,
    this.playUrl,
    this.covers,
    this.coversMedium,
    this.coversLarger,
  });

  MusicInfos.fromJson(Map<String, dynamic> json) {
    musicId = json['musicId'];
    musicName = json['musicName'];
    authorName = json['authorName'];
    original = json['original'].toString();
    playUrl = json['playUrl'].cast<String>();
    covers = json['covers'].cast<String>();
    coversMedium = json['coversMedium'].cast<String>();
    coversLarger = json['coversLarger'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['musicId'] = musicId;
    data['musicName'] = musicName;
    data['authorName'] = authorName;
    data['original'] = original;
    data['playUrl'] = playUrl;
    data['covers'] = covers;
    data['coversMedium'] = coversMedium;
    data['coversLarger'] = coversLarger;
    return data;
  }
}

class ChallengeInfoList {
  String? challengeId;
  String? challengeName;
  bool? isCommerce;
  String? text;
  List<String>? covers;
  List<String>? coversMedium;
  List<String>? coversLarger;
  String? splitTitle;

  ChallengeInfoList({
    this.challengeId,
    this.challengeName,
    this.isCommerce,
    this.text,
    this.covers,
    this.coversMedium,
    this.coversLarger,
    this.splitTitle,
  });

  ChallengeInfoList.fromJson(Map<String, dynamic> json) {
    challengeId = json['challengeId'];
    challengeName = json['challengeName'];
    isCommerce = json['isCommerce'];
    text = json['text'];
    covers = json['covers'].cast<String>();
    coversMedium = json['coversMedium'].cast<String>();
    coversLarger = json['coversLarger'].cast<String>();
    splitTitle = json['splitTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['challengeId'] = challengeId;
    data['challengeName'] = challengeName;
    data['isCommerce'] = isCommerce;
    data['text'] = text;
    data['covers'] = covers;
    data['coversMedium'] = coversMedium;
    data['coversLarger'] = coversLarger;
    data['splitTitle'] = splitTitle;
    return data;
  }
}

class TextExtra {
  String? awemeId;
  int? start;
  int? end;
  String? hashtagName;
  String? hashtagId;
  int? type;
  String? userId;
  bool? isCommerce;

  TextExtra({
    this.awemeId,
    this.start,
    this.end,
    this.hashtagName,
    this.hashtagId,
    this.type,
    this.userId,
    this.isCommerce,
  });

  TextExtra.fromJson(Map<String, dynamic> json) {
    awemeId = json['AwemeId'];
    start = json['Start'];
    end = json['End'];
    hashtagName = json['HashtagName'];
    hashtagId = json['HashtagId'];
    type = json['Type'];
    userId = json['UserId'];
    isCommerce = json['IsCommerce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AwemeId'] = awemeId;
    data['Start'] = start;
    data['End'] = end;
    data['HashtagName'] = hashtagName;
    data['HashtagId'] = hashtagId;
    data['Type'] = type;
    data['UserId'] = userId;
    data['IsCommerce'] = isCommerce;
    return data;
  }
}

class AuthorStats {
  int? followingCount;
  int? followerCount;
  String? heartCount;
  int? videoCount;
  int? diggCount;

  AuthorStats({
    this.followingCount,
    this.followerCount,
    this.heartCount,
    this.videoCount,
    this.diggCount,
  });

  AuthorStats.fromJson(Map<String, dynamic> json) {
    followingCount = json['followingCount'];
    followerCount = json['followerCount'];
    heartCount = json['heartCount'];
    videoCount = json['videoCount'];
    diggCount = json['diggCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['followingCount'] = followingCount;
    data['followerCount'] = followerCount;
    data['heartCount'] = heartCount;
    data['videoCount'] = videoCount;
    data['diggCount'] = diggCount;
    return data;
  }
}
