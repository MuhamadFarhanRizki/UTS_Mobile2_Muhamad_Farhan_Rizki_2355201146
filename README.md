🎓 UTS Mobile Programming 2 

Nama : Muhamad Farhan Rizki

Nim  : 23552011416

kelas: TIFK-23A

Dosen Pengampu : Erryck Norrys, S.Kom.

Profile Single App 
Aplikasi Single Page Profile ini dibuat sebagai pemenuhan tugas UTS mata kuliah Mobile Programming 2.
Aplikasi dibangun menggunakan Flutter dengan penerapan state management (Cubit), custom widget, manipulasi data, serta custom animation.

📱 Fitur Utama

✅ 1. Single Page Application (SPA)

Seluruh informasi ditampilkan dalam satu halaman ProfilePage() (tanpa navigasi tambahan).

🎨 2. Tema Light & Dark Mode (State Management Cubit)

Aplikasi ini menggunakan pengaturan tema yang diterapkan secara global melalui ThemeData.
Tema mendukung mode terang dan mode gelap, dikontrol melalui ThemeCubit.

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  void toggleTheme() => emit(!state);
}

Tema terang:

Header "Profil Mahasiswa" menggunakan warna biru pastel cerah.

Background menggunakan gradasi putih ke biru muda agar lebih aesthetic.

Card memiliki shadow ringan dan tekstur lembut.


Tema gelap:

Menggunakan nuansa teal dan hitam.

Memiliki animasi background partikel khusus di body.


Font:

Menggunakan GoogleFonts.poppins, sesuai ketentuan UTS (menggunakan package eksternal).

🧩 3. Custom Widget

Aplikasi ini menggunakan beberapa custom widget agar struktur kode lebih rapi, mudah dipahami, tidak adanya duplikasi data dan modular. 

Custom widget yang digunakan:

1. InfoCard
Untuk menampilkan informasi dasar seperti NIM, Email, Kelas, dan lainnya dalam bentuk card yang rapi.

3. HobbyItem
Untuk menampilkan daftar hobi dalam bentuk grid.

4. SkillItem
Untuk menampilkan daftar keahlian dalam bentuk list.

Contoh Custom Widget – InfoCard

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

Project ini sudah menggunakan semua komponen UI yang diwajibkan pada ketentuan UTS. Penjelasan berikut menjelaskan komponen apa saja yang digunakan dan di bagian mana mereka diterapkan:

A. Stack

Stack digunakan sebagai struktur utama pada bagian AppBar custom di mode terang, yaitu pada area header "Profil Mahasiswa" yang memiliki animasi partikel di latar belakang. Stack memungkinkan widget background dan foreground bertumpuk dengan rapi.

B. Text, Image, dan Icon

Text digunakan pada seluruh bagian biodata, judul section, dan deskripsi.

Image digunakan untuk menampilkan foto profil mahasiswa di bagian header.

Icon digunakan pada InfoCard (NIM, Email, Kelas), tombol tema (dark/light mode), dan juga pada item hobi serta keahlian.

C. Row & Column

Row dan Column digunakan untuk menyusun layout halaman, termasuk:

Header profil (foto dan teks disejajarkan secara vertikal maupun horizontal).

Penataan item biodata.

Bagian keahlian dan hobi yang memerlukan penataan elemen secara rapi.

D. Container

Container digunakan pada berbagai elemen untuk:

Memberikan paddings dan margin.

Mengatur background gradient pada mode terang.

Mengatur dekorasi seperti radius pada box dan card.

D. Card dan ListTile

Digunakan pada InfoCard untuk menampilkan data seperti NIM, Email, dan lainnya.
ListTile digunakan sebagai elemen utama dalam InfoCard agar format informasi rapi dan konsisten.

E. ListView.builder

ListView.builder digunakan untuk menampilkan daftar keahlian (SkillItem).
Dengan builder, daftar bisa dibuat dinamis, efisien, dan scalable.

F. GridView.builder

GridView.builder digunakan pada daftar hobi, sehingga tampilan hobi menjadi kotak-kotak dalam grid yang proporsional.
  
🧮 4. Model Data Menggunakan Class

Aplikasi memiliki model data buatan sendiri (Profile):

class Profile {
  final String nama;
  final String nim;
  final List<String> hobi;
  final List<String> skill;
  final Status status;
}

Termasuk enum:

enum Status { aktif, cuti, lulus }

🔧 5. Manipulasi Data (Wajib UTS)

Aplikasi menerapkan manipulasi data pada beberapa bagian:

A. Manipulasi State Tema

themeCubit.toggleTheme(); // state berubah → UI berubah

B. Mengolah List Hobi & Skill

Data dimuat dalam List lalu dibuild secara dinamis:

ListView.builder(
  itemCount: profile.hobi.length,

C. Mapping String → Icon

IconData _getHobbyIcon(String hobby) { ... }

D. Animasi Mengubah Data Koordinat

CustomPainter mengubah posisi bintang setiap frame:

dy = (random.nextDouble() * size.height +
      math.sin(progress * 2 * math.pi) * 10);

E. Animated Message

_showAnimatedMessage("⭐ Hebat!");

➡ Semua termasuk manipulasi data sesuai ketentuan UTS.

🌟 6. Custom Animation

Aplikasi menggunakan:

AnimationController

AnimatedSwitcher

AnimatedOpacity

AnimatedContainer

AnimatedScale

CustomPainter animasi partikel AppBar

CustomPainter animasi bintang background

🖼 7. Asset Gambar

Semua asset sudah terdaftar:

assets/images/profile.jpeg
assets/images/header_bg.jpeg

📂 Struktur Folder

assets/
└── images/
    ├── profile.jpeg
    └── header_bg.jpeg
    
lib/
│
├── cubit/
│   └── theme_cubit.dart
│
├── models/
│   └── profile.dart
│
├── pages/
│   └── profile_page.dart
│
├── widgets/
│   ├── info_card.dart
│   ├── hobby_item.dart
│   └── skill_item.dart
│
└── main.dart   ← Entry point aplikasi

 Hasil Run Project

▶️<img width="532" height="772" alt="Screenshot 2025-11-19 114109" src="https://github.com/user-attachments/assets/83418184-14ea-4e78-be57-4fa765ae4b05" />

<img width="527" height="812" alt="Screenshot 2025-11-19 114122" src="https://github.com/user-attachments/assets/7934e023-6f44-458e-8936-faf0330f9652" />

<img width="529" height="840" alt="Screenshot 2025-11-19 114140" src="https://github.com/user-attachments/assets/a7335ac9-10a3-4c45-a08e-2a77e329a1f9" />

<img width="597" height="861" alt="Screenshot 2025-11-19 114152" src="https://github.com/user-attachments/assets/57905bc0-9a76-4fb3-b957-160e8708b410" />

