import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Save Places to Firestore
Future<void> savePlacesToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("myAppCollection");
  for (final Place place in listOfPlace) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
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

  Place({
    required this.title,
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
    required this.imageUrls,
  });

  // Convert data to Map with formatted price
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

/// Data List
final List<Place> listOfPlace = [
  Place(
    isActive: true,
    title: "Kamar Nyaman di Rumah Sederhana",
    image: "https://www.momondo.in/himg/b1/a8/e3/revato-1172876-6930557-765128.jpg",
    rating: 4.85,
    review: 126,
    bedAndBathroom: "1 kasur . Kamar mandi bersama",
    date: "Nov 11-16",
    price: 380000,
    address: "Batam Center, Batam",
    vendor: "Bu Sari",
    vendorProfession: "Ibu Rumah Tangga",
    yearOfHostin: 10,
    vendorProfile:
        "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
    latitude: 1.1347,
    longitude: 104.0486,
    imageUrls: [
      "https://media.timeout.com/images/105162711/image.jpg",
      "https://www.telegraph.co.uk/content/dam/Travel/hotels/2023/september/one-and-only-cape-town-product-image.jpg",
    ],
  ),
  Place(
    isActive: false,
    title: "Kamar Cozy di Apartemen Megah",
    image: "https://www.telegraph.co.uk/content/dam/Travel/hotels/2023/september/one-and-only-cape-town-product-image.jpg",
    rating: 4.55,
    date: "Oct 01-06",
    review: 26,
    yearOfHostin: 6,
    bedAndBathroom: "1 kasur double . Kamar mandi bersama",
    price: 880000,
    address: "Nagoya, Batam",
    vendor: "Pak Anto",
    vendorProfession: "Pegawai Swasta",
    vendorProfile: "https://www.perfocal.com/blog/content/images/size/w960/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg",
    latitude: 1.1446,
    longitude: 104.0027,
    imageUrls: [
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/de/f7/c3/standard-room.jpg?w=1200&h=-1&s=1",
    ],
  ),
];
