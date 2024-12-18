// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> savePlacesToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("myAppCpollection");
  for (final Place place in listOfPlace) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(place.toMap());
  }
}

class Place {
  final String title;
  bool isActive;
  final String image;
  final double rating;
  final String date;
  final int price;
  final String address;
  final String vendor;
  final String vendorProfession;
  final String vendorProfile;
  final int review;
  final String bedAndBathroom;
  final int yearOfHostin;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;

  Place(
      {required this.title,
      required this.isActive,
      required this.image,
      required this.rating,
      required this.date,
      required this.price,
      required this.address,
      required this.vendor,
      required this.vendorProfession,
      required this.vendorProfile,
      required this.review,
      required this.bedAndBathroom,
      required this.yearOfHostin,
      required this.latitude,
      required this.longitude,
      required this.imageUrls});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isActive': isActive,
      'image': image,
      'rating': rating,
      'date': date,
      'price': price,
      'address': address,
      'vendor': vendor,
      'vendorProfession': vendorProfession,
      'vendorProfile': vendorProfile,
      'review': review,
      'bedAndBathroom': bedAndBathroom,
      'yearOfHostin': yearOfHostin,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrls': imageUrls,
    };
  }
}


final List<Place> listOfPlace = [
  Place(
    isActive: true,
    title: "Kamar Nyaman di Rumah Sederhana",
    image:
        "https://www.momondo.in/himg/b1/a8/e3/revato-1172876-6930557-765128.jpg",
    rating: 4.85,
    review: 126,
    bedAndBathroom: "1 kasur . Kamar mandi bersama",
    date: "Nov 11-16",
    price: 38,
    address: "Batam Center, Batam",
    vendor: "Bu Sari",
    vendorProfession: "Ibu Rumah Tangga",
    yearOfHostin: 10,
    vendorProfile:
        "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
    latitude: 1.1347,
    longitude: 104.0486,
    imageUrls: [
      "https://www.momondo.in/himg/b1/a8/e3/revato-1172876-6930557-765128.jpg",
      "https://media.timeout.com/images/105162711/image.jpg",
      "https://www.telegraph.co.uk/content/dam/Travel/hotels/2023/september/one-and-only-cape-town-product-image.jpg",
      "https://www.theindiahotel.com/extra-images/banner-01.jpg",
    ],
  ),
  Place(
    isActive: false,
    title: "Kamar Cozy di Apartemen Megah",
    image:
        "https://www.telegraph.co.uk/content/dam/Travel/hotels/2023/september/one-and-only-cape-town-product-image.jpg",
    rating: 4.55,
    date: "Oct 01-06",
    review: 26,
    yearOfHostin: 6,
    bedAndBathroom: "1 kasur double . Kamar mandi bersama",
    price: 88,
    address: "Nagoya, Batam",
    vendor: "Pak Anto",
    vendorProfession: "Pegawai Swasta",
    vendorProfile:
        "https://www.perfocal.com/blog/content/images/size/w960/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg",
    latitude: 1.1446,
    longitude: 104.0027,
    imageUrls: [
      "https://www.telegraph.co.uk/content/dam/Travel/hotels/2023/september/one-and-only-cape-town-product-image.jpg",
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/de/f7/c3/standard-room.jpg?w=1200&h=-1&s=1",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuMkI1MoQDzLBF-prjIp6kyXpccVol16bsew&s"
    ],
  ),
  Place(
    isActive: true,
    title: "Kamar Cerah di Apartemen Elite",
    image: "https://www.theindiahotel.com/extra-images/banner-01.jpg",
    rating: 4.77,
    date: "Oct 10-16",
    price: 34,
    address: "Batu Ampar, Batam",
    yearOfHostin: 4,
    review: 160,
    bedAndBathroom: "1 kasur . Kamar mandi bersama",
    vendor: "Ibu Dewi",
    vendorProfession: "Wiraswasta",
    vendorProfile:
        "https://shotkit.com/wp-content/uploads/bb-plugin/cache/cool-profile-pic-matheus-ferrero-landscape-6cbeea07ce870fc53bedd94909941a4b-zybravgx2q47.jpeg",
    latitude: 1.1691,
    longitude: 104.0210,
    imageUrls: [
      "https://www.theindiahotel.com/extra-images/banner-01.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgCXf3HATaGRx4_GtvzW8FVnYfXKRQMuRzOg&s",
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/de/f7/c3/standard-room.jpg?w=1200&h=-1&s=1",
      "https://radissonhotels.iceportal.com/image/radisson-hotel-kathmandu/exterior/16256-114182-f75152296_3xl.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1P0AxSntzNAgs2_Qnl1IJCb2EebN82-KbPg&s",
    ],
  ),
  Place(
    isActive: true,
    title: "Tempat Tenang di Kawasan Marina",
    image:
        "https://lyon.intercontinental.com/wp-content/uploads/sites/6/2019/11/Superior-Room-cEric-Cuvillier-2.jpg",
    rating: 4.33,
    date: "Dec 17-22",
    price: 76,
    address: "Marina City, Batam",
    yearOfHostin: 8,
    review: 236,
    bedAndBathroom: "2 kasur queen . Kamar mandi bersama",
    vendor: "Pak Hendra",
    vendorProfession: "Guru",
    vendorProfile:
        "https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.webp?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=",
    latitude: 1.0931,
    longitude: 103.9902,
    imageUrls: [
      "https://lyon.intercontinental.com/wp-content/uploads/sites/6/2019/11/Superior-Room-cEric-Cuvillier-2.jpg",
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/de/f7/c3/standard-room.jpg?w=1200&h=-1&s=1",
      "https://www.grandhotelnepal.com/images/slideshow/3arzB-grand4.jpg",
    ],
  ),
  Place(
    isActive: false,
    title: "Kamar Suite @ Pantai Nongsa",
    image: "https://media.timeout.com/images/105162711/image.jpg",
    rating: 4.90,
    date: "Jan 26-29",
    price: 160,
    review: 292,
    yearOfHostin: 10,
    bedAndBathroom: "1 kasur double . Kamar mandi pribadi",
    address: "Nongsa, Batam",
    vendor: "Bu Lina",
    vendorProfession: "Pemilik Villa",
    vendorProfile:
        "https://media.istockphoto.com/id/1476171646/photo/young-woman-ready-for-job-business-concept.webp?b=1&s=170667a&w=0&k=20&c=oegktY4Hijr4wOelujTp81I0BJPjD6Q-lb5BpwOj0kA=",
    latitude: 1.1827,
    longitude: 104.0647,
    imageUrls: [
      "https://media.timeout.com/images/105162711/image.jpg",
      "https://www.momondo.in/himg/b1/a8/e3/revato-1172876-6930557-765128.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_Kz2H05mZVaPIZWVbXRADEASKvBCLJv4oeg&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRctRmBUpKa5HWwWKaL9TeVTZNHfabImL8cLQ&s",
    ],
  ),
];

