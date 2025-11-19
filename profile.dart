enum Status { aktif, cuti, lulus }

class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final List<String> hobi;
  final List<String> skill;
  final Status status;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.hobi,
    required this.skill,
    required this.status,
  });

  String get statusLabel {
    switch (status) {
      case Status.aktif:
        return 'Aktif';
      case Status.cuti:
        return 'Cuti';
      case Status.lulus:
        return 'Lulus';
    }
  }
}
