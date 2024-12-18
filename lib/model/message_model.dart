class Message {
  final String image;
  final String vendorImage;
  final String name;
  final String date;
  final String description;
  final String duration;

  Message({
    required this.image,
    required this.vendorImage,
    required this.name,
    required this.date,
    required this.description,
    required this.duration,
  });
}

final List<Message> messages = [
  Message(
    image:
        "https://cdn-2.tstatic.net/jatim/foto/bank/images/taman-impian-jaya-ancol_20170927_113949.jpg",
    vendorImage:
        "https://asset.kompas.com/crops/8BDPOecgdIsU0MxNoHIzA-b2D2M=/0x0:1000x667/750x500/data/photo/2022/08/04/62eb8501ecb51.jpg",
    name: "Budi Santoso",
    date: "25/08/2023",
    description: "Pesan untuk Taman Impian Jaya Ancol sudah dikonfirmasi.",
    duration: "Sep 5-8, 2024 Jakarta",
  ),
  Message(
    image:
        "https://asset.kompas.com/crops/QONmj-6iIIO8lMe9gKgn9fiFiKo=/0x0:780x520/780x520/data/photo/2021/03/23/6059d8aa46b60.jpg",
    vendorImage:
        "https://akcdn.detik.net.id/community/media/visual/2022/03/30/cool-and-handsome-man.jpg?w=700&q=90",
    name: "Rahmat Hidayat",
    date: "10/09/2023",
    description: "Reservasi untuk Pantai Kuta telah dikonfirmasi.",
    duration: "Oct 10-14, 2024 Bali",
  ),
  Message(
    image:
        "https://images.unsplash.com/photo-1570415513507-c69145d1e8e1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    vendorImage:
        "https://cdn1.katadata.co.id/media/images/thumb/2023/06/21/Pekerja-2023_06_21-17_35_41_8c9d52bba10a0d83bb877d2d7d3b8703.jpg",
    name: "Siti Aisyah",
    date: "15/10/2023",
    description: "Pesanan Hotel di Bandung berhasil dibuat.",
    duration: "Dec 15-19, 2024 Bandung",
  ),
  Message(
    image:
        "https://cdn.idntimes.com/content-images/post/20230223/202207171635-main-image-siska-rosdiana-nr-2ea6c013b8f1ad6431f3c130a79a82fb_600x400.jpg",
    vendorImage:
        "https://images.unsplash.com/photo-1542903660-eedba2cda473?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    name: "Ahmad Fauzi",
    date: "22/11/2023",
    description: "Tiket wisata ke Kawah Putih Ciwidey telah dikonfirmasi.",
    duration: "Jan 2-6, 2025 Ciwidey",
  ),
];
