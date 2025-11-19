import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../models/profile.dart';
import '../widgets/info_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late Profile profile;
  bool showMessage = false;
  String message = "";
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    profile = Profile(
      nama: "Muhamad Farhan Rizki",
      nim: "23552011416",
      jurusan: "Teknik Informatika",
      email: "farhanrizki1903@gmail.com",
      telepon: "+62 881-0235-5375",
      hobi: ["Menonton", "Membaca Buku", "Music"],
      skill: ["Flutter", "Design", "Drawing", "Write Poetry"],
      status: Status.aktif,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); //
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getHobbyIcon(String hobby) {
    switch (hobby.toLowerCase()) {
      case "menonton":
        return Icons.movie_creation_rounded;
      case "music":
        return Icons.music_note_rounded;
      case "membaca buku":
        return Icons.menu_book_rounded;
      case "menggambar":
        return Icons.brush_rounded;
      default:
        return Icons.favorite_rounded;
    }
  }

  IconData _getSkillIcon(String skill) {
    switch (skill.toLowerCase()) {
      case "flutter":
        return Icons.flutter_dash_rounded;
      case "design":
        return Icons.palette_rounded;
      case "drawing":
        return Icons.edit_rounded;
      case "write poetry":
        return Icons.menu_book_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  void _showAnimatedMessage(String newMessage) {
    setState(() {
      message = newMessage;
      showMessage = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showMessage = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isDarkMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      // APP BAR DENGAN ANIMASI BINTANG MINI BIRU SAAT TERANG
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: !isDarkMode
                  ? AnimatedBuilder(
                      key: const ValueKey("particles"),
                      animation: _controller,
                      builder: (_, __) {
                        return CustomPaint(
                          painter:
                              _BlueParticleAppBarPainter(_controller.value),
                          size: Size.infinite,
                        );
                      },
                    )
                  : Container(
                      key: const ValueKey("dark"),
                      color: Colors.blueGrey[900],
                    ),
            ),
            AppBar(
              title: const Text('Profil Mahasiswa'),
              centerTitle: true,
              elevation: 4,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: BlocBuilder<ThemeCubit, bool>(
                    builder: (context, isDarkMode) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, anim) =>
                            RotationTransition(turns: anim, child: child),
                        child: Icon(
                          isDarkMode
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round_rounded,
                          key: ValueKey(isDarkMode),
                          color:
                              isDarkMode ? Colors.yellowAccent : Colors.orange,
                        ),
                      );
                    },
                  ),
                  onPressed: () => themeCubit.toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),

      // LATAR ANIMASI BINTANG + ISI HALAMAN
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: _StarBackgroundPainter(_controller.value),
                size: Size.infinite,
              );
            },
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 220,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/header_bg.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpeg'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Muhamad Farhan Rizki",
                          style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold,
                            color: Colors.black, // Tetap hitam
                          ),
                        ),
                        const Text(
                          "Teknik Informatika",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 12,
                      right: 20,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, __) => Transform.rotate(
                          angle: _controller.value * 2 * math.pi,
                          child: const Icon(Icons.star_rounded,
                              color: Colors.yellowAccent, size: 28),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildBorderedInfoCard(
                    Icons.school, "NIM", profile.nim, primaryColor),
                _buildBorderedInfoCard(
                    Icons.mail, "Email", profile.email, primaryColor),
                _buildBorderedInfoCard(
                    Icons.phone, "Telepon", profile.telepon, primaryColor),
                _buildBorderedInfoCard(Icons.check_circle_outline, "Status",
                    profile.statusLabel, primaryColor),
                const SizedBox(height: 20),
                const Text("Keahlian",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GridView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: profile.skill.length,
                  itemBuilder: (context, index) {
                    final skill = profile.skill[index];
                    return GestureDetector(
                      onTap: () {
                        switch (skill.toLowerCase()) {
                          case "flutter":
                            _showAnimatedMessage(
                                "🚀 Keahlianmu di Flutter makin keren!");
                            break;
                          case "design":
                            _showAnimatedMessage("🎨 Desainmu selalu memukau!");
                            break;
                          case "drawing":
                            _showAnimatedMessage(
                                "✏️ Gambar kamu penuh kreativitas!");
                            break;
                          case "write poetry":
                            _showAnimatedMessage(
                                "📝 Puisimu sungguh indah dan bermakna!");
                            break;
                          default:
                            _showAnimatedMessage("⭐ Hebat!");
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: primaryColor, width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_getSkillIcon(skill), color: primaryColor),
                            const SizedBox(width: 8),
                            Text(skill,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text("Hobi",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profile.hobi.length,
                  itemBuilder: (context, index) {
                    final hobby = profile.hobi[index];
                    return GestureDetector(
                      onTap: () {
                        _showAnimatedMessage(
                            "✨ Wah semangat terus dalam melakukan hobinya! ✨");
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: primaryColor, width: 1.2),
                        ),
                        child: ListTile(
                          leading: Icon(_getHobbyIcon(hobby),
                              color: Theme.of(context).colorScheme.secondary),
                          title: Text(hobby),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: showMessage ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      style: const TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBorderedInfoCard(
      IconData icon, String title, String value, Color borderColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: InfoCard(icon: icon, title: title, value: value),
    );
  }
}

// Painter untuk animasi bintang di latar belakang
class _StarBackgroundPainter extends CustomPainter {
  final double progress;
  _StarBackgroundPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.yellow.withOpacity(0.25);
    final random = math.Random(3);
    for (int i = 0; i < 20; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = (random.nextDouble() * size.height +
              math.sin(progress * 2 * math.pi) * 10) %
          size.height;
      canvas.drawCircle(Offset(dx, dy), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarBackgroundPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// Painter untuk partikel biru kecil di AppBar
class _BlueParticleAppBarPainter extends CustomPainter {
  final double progress;
  _BlueParticleAppBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent.withOpacity(0.4);
    final random = math.Random(1);
    for (int i = 0; i < 6; i++) {
      final dx = (random.nextDouble() * size.width + progress * 50 * (i + 1)) %
          size.width;
      final dy = size.height / 2 + math.sin(progress * 2 * math.pi + i) * 5;
      canvas.drawCircle(Offset(dx, dy), 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BlueParticleAppBarPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
