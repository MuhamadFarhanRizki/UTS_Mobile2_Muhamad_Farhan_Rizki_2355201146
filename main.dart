import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/theme_cubit.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const ProfileApp(),
    ),
  );
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        // 🎨 Tema terang dan gelap
        final lightColors = ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
          brightness: Brightness.light,
          primary:
              const Color(0xFF6CA8FF), // biru pastel cerah untuk elemen utama
          secondary: const Color(0xFFB2EBF2),
          background: const Color(0xFFF4F8FF), // agak kebiruan lembut
        );

        final darkColors = ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
          primary: const Color(0xFF26A69A),
          secondary: const Color(0xFF80CBC4),
          background: const Color(0xFF121212),
        );

        return AnimatedTheme(
          data: ThemeData(
            colorScheme: isDarkMode ? darkColors : lightColors,
            textTheme: GoogleFonts.poppinsTextTheme(),
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            useMaterial3: true,

            // 🌈 AppBar warna biru pastel terang
            appBarTheme: AppBarTheme(
              elevation: 3,
              backgroundColor: isDarkMode
                  ? darkColors.primary.withOpacity(0.4)
                  : const Color(0xFF6CA8FF), // biru pastel terang
              titleTextStyle: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              centerTitle: true,
            ),

            // 🩵 Scaffold Background gradasi putih ke biru lembut
            scaffoldBackgroundColor:
                isDarkMode ? darkColors.background : Colors.transparent,
          ),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubicEmphasized,
          child: Container(
            decoration: !isDarkMode
                ? const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF9FBFF), // putih kebiruan
                        Color.fromARGB(255, 29, 123, 223), // biru lembut
                      ],
                    ),
                  )
                : null,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Profile App',
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(colorScheme: lightColors),
              darkTheme: ThemeData(colorScheme: darkColors),
              home: const ProfilePage(),
            ),
          ),
        );
      },
    );
  }
}
