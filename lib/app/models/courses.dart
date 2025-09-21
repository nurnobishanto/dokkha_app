class Courses {
  final int? currentPage;
  final List<Data>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Courses({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Data {
  final int? id;
  final int? accessDuration;
  final String? title;
  final String? slug;
  final String? details;
  final String? duration;
  final int? courseCategoryId;
  final String? image;
  final String? regularPrice;
  final String? salePrice;
  final dynamic meetLink;
  final dynamic whatsappGroupLink;
  final dynamic facebookGroup;
  final dynamic zoomLink;
  final dynamic youtubePlaylist;
  final dynamic telegramGroup;
  final int? order;
  final DateTime? publishDate;
  final int? status;
  final dynamic promotionVideo;
  final int? isExamBatch;
  final int? lifetimeAccess;
  final int? featured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? modulesCount;
  final int? itemsCount;

  Data({
    this.id,
    this.accessDuration,
    this.title,
    this.slug,
    this.details,
    this.duration,
    this.courseCategoryId,
    this.image,
    this.regularPrice,
    this.salePrice,
    this.meetLink,
    this.whatsappGroupLink,
    this.facebookGroup,
    this.zoomLink,
    this.youtubePlaylist,
    this.telegramGroup,
    this.order,
    this.publishDate,
    this.status,
    this.promotionVideo,
    this.isExamBatch,
    this.lifetimeAccess,
    this.featured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.modulesCount,
    this.itemsCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    accessDuration: json["access_duration"],
    title: json["title"],
    slug: json["slug"],
    details: json["details"],
    duration: json["duration"],
    courseCategoryId: json["course_category_id"],
    image: json["image"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    meetLink: json["meet_link"],
    whatsappGroupLink: json["whatsapp_group_link"],
    facebookGroup: json["facebook_group"],
    zoomLink: json["zoom_link"],
    youtubePlaylist: json["youtube_playlist"],
    telegramGroup: json["telegram_group"],
    order: json["order"],
    publishDate: json["publish_date"] == null ? null : DateTime.parse(json["publish_date"]),
    status: json["status"],
    promotionVideo: json["promotion_video"],
    isExamBatch: json["is_exam_batch"],
    lifetimeAccess: json["lifetime_access"],
    featured: json["featured"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    modulesCount: json["modules_count"],
    itemsCount: json["items_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "access_duration": accessDuration,
    "title": title,
    "slug": slug,
    "details": details,
    "duration": duration,
    "course_category_id": courseCategoryId,
    "image": image,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "meet_link": meetLink,
    "whatsapp_group_link": whatsappGroupLink,
    "facebook_group": facebookGroup,
    "zoom_link": zoomLink,
    "youtube_playlist": youtubePlaylist,
    "telegram_group": telegramGroup,
    "order": order,
    "publish_date": "${publishDate!.year.toString().padLeft(4, '0')}-${publishDate!.month.toString().padLeft(2, '0')}-${publishDate!.day.toString().padLeft(2, '0')}",
    "status": status,
    "promotion_video": promotionVideo,
    "is_exam_batch": isExamBatch,
    "lifetime_access": lifetimeAccess,
    "featured": featured,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "modules_count": modulesCount,
    "items_count": itemsCount,
  };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
