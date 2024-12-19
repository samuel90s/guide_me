import 'package:guide_me/Components/my_icon_button.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithCustomInfoWindows extends StatefulWidget {
  const MapWithCustomInfoWindows({super.key});

  @override
  State<MapWithCustomInfoWindows> createState() =>
      _MapWithCustomInfoWindowsState();
}

class _MapWithCustomInfoWindowsState extends State<MapWithCustomInfoWindows> {
  LatLng myCurrentLocation = const LatLng(27.7172, 85.3240);
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("myAppCpollection");
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "asset/images/marker.png",
    );

    placeCollection.snapshots().listen((QuerySnapshot streamSnapshot) {
      if (streamSnapshot.docs.isNotEmpty) {
        final List allMarkers = streamSnapshot.docs;
        List<Marker> myMarker = [];
        for (final marker in allMarkers) {
          final dat = marker.data();
          final data = (dat) as Map;
          final List<String> imageUrls =
              (data['imageUrls'] as List?)?.cast<String>() ?? [];
          final double rating =
              data['rating'] != null ? data['rating'] as double : 0.0;
          final int price =
              data['price'] != null ? data['price'] as int : 0;

          myMarker.add(
  Marker(
    markerId: MarkerId("${data['latitude']},${data['longitude']}"),
    position: LatLng(data['latitude'], data['longitude']),
    onTap: () {
      _customInfoWindowController.addInfoWindow!(
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: AnotherCarousel(
                        images: imageUrls.map((url) => NetworkImage(url)).toList(),
                        dotSize: 5,
                        indicatorBgPadding: 5,
                        dotBgColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: const Text(
                            "Guest Favorite",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const MyIconButton(
                          icon: Icons.favorite_border,
                          radius: 15,
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            _customInfoWindowController.hideInfoWindow!();
                          },
                          child: const MyIconButton(
                            icon: Icons.close,
                            radius: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                data["address"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "3066 m elevation",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['date'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FittedBox(
                          child: Text.rich(
                            TextSpan(
                              text: "Rp. ${price.toString().replaceAllMapped(
                                RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},',
                              )} ",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: const [
                                TextSpan(
                                  text: "/night",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _customInfoWindowController.hideInfoWindow!();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        LatLng(data['latitude'], data['longitude']),
      );
    },
    icon: customIcon,
  ),
);

        }
        setState(() {
          markers = myMarker;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {
        showModalBottomSheet(
          clipBehavior: Clip.none,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.77,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: myCurrentLocation),
                    onMapCreated: (GoogleMapController controller) {
                      googleMapController = controller;
                      _customInfoWindowController.googleMapController =
                          controller;
                    },
                    onTap: (argument) {
                      _customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {
                      _customInfoWindowController.onCameraMove!();
                    },
                    markers: markers.toSet(),
                  ),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    height: MediaQuery.of(context).size.height * 0.34,
                    width: MediaQuery.of(context).size.width * 0.85,
                    offset: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 170,
                        vertical: 5,
                      ),
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      label: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            SizedBox(width: 5),
            Text(
              "Map",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.map_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
