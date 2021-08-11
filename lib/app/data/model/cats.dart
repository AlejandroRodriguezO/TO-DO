// To parse this JSON data, do
//
//     final cats = catsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cats catsFromMap(String str) => Cats.fromMap(json.decode(str));

String catsToMap(Cats data) => json.encode(data.toMap());

class Cats {
    Cats({
        @required this.currentPage,
        @required this.data,
        @required this.firstPageUrl,
        @required this.from,
        @required this.lastPage,
        @required this.lastPageUrl,
        @required this.links,
        @required this.nextPageUrl,
        @required this.path,
        @required this.perPage,
        @required this.prevPageUrl,
        @required this.to,
        @required this.total,
    });

    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    String nextPageUrl;
    String path;
    String perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Cats.fromMap(Map<String, dynamic> json) => Cats(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    Datum({
        @required this.fact,
        @required this.length,
    });

    String fact;
    int length;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        fact: json["fact"],
        length: json["length"],
    );

    Map<String, dynamic> toMap() => {
        "fact": fact,
        "length": length,
    };
}

class Link {
    Link({
        @required this.url,
        @required this.label,
        @required this.active,
    });

    String url;
    String label;
    bool active;

    factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
    };
}
