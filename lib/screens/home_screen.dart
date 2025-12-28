import 'package:business_card/models/experience.dart';
import 'package:business_card/models/social_media.dart';
import 'package:business_card/utils/app_text_styles.dart';
import 'package:business_card/widgets/app_scaffold.dart';
import 'package:business_card/widgets/social_media_button.dart';
import 'package:business_card/widgets/text_card.dart';
import 'package:business_card/widgets/user_header.dart';
import 'package:business_card/widgets/bullet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Experience> workHistory = [
    Experience(
      title: "Software Developer",
      place: "at Thinking Big",
      period: "from May 2025 to Present",
      description: "Worked as a full-stack developer, building applications using .NET Core and Angular.",
      skills: [".NET Core", "Angular", "MySQL", "Docker"],
    ),
    Experience(
      title: "Software Developer",
      place: "at Popular Nas Redes",
      period: "from Jan 2021 to Jul 2024",
      description:
          "Worked as a full-stack developer, building and maintaining applications using PHP, Node.js, and Python.",
      skills: ["PHP", "MySQL", "Node.js", "Python", "Bootstrap"],
    ),
  ];

  static const List<Experience> education = [
    Experience(
      title: "Computer Information Systems",
      place: "at Holland College",
      period: "from Sep 2024 to Apr 2026",
      description: "Two-year Computer Information Systems diploma at Holland College.",
      skills: [
        "OOP",
        "Web Dev",
        "Cybersecurity",
        "Network Communications",
        "Database Management",
        "System Analysis & Design",
        "E-Health",
      ],
    ),
  ];

  static const List<SocialMedia> socialMedias = [
    SocialMedia(
      icon: MdiIcons.linkedin,
      url: 'linkedin://profile/sandro-mai',
      webUrl: 'https://www.linkedin.com/in/sandro-mai/',
    ),
    SocialMedia(
      icon: MdiIcons.github,
      url: 'github://user/sandromai',
      webUrl: 'https://github.com/sandromai',
    ),
    SocialMedia(icon: MdiIcons.email, url: 'mailto:sandromai6@gmail.com'),
    SocialMedia(icon: MdiIcons.phone, url: 'tel:+17823771844'),
  ];

  late final ScrollController _scrollController;

  UserHeader? _header;
  bool _isSnapping = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    if (_header == null || _header!.statusBarHeight != statusBarHeight) {
      _header = UserHeader(
        name: "Sandro Mai",
        avatar: "assets/images/profile_picture.webp",
        statusBarHeight: statusBarHeight,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Listener(
        onPointerUp: (_) => _snapHeader(delayed: false),
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _snapHeader(delayed: true);
            return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(pinned: true, delegate: _header!),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(child: Text("Full-stack Developer", style: AppTextStyles.subtitle)),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 12,
                              runSpacing: 6,
                              children: socialMedias.map((sm) => SocialMediaButton(socialMedia: sm)).toList(),
                            ),
                          ),
                          const _ProfileDescription(),
                          const Center(
                            child: BulletList([
                              "JS, TS, HTML, CSS",
                              "PHP, Node.js, MySQL",
                              "Flutter, Angular, React",
                            ], horizontal: true),
                          ),
                          _ProfileSection(
                            title: "Work History",
                            children: workHistory.map((exp) => _ExperienceCard(exp: exp)).toList(),
                          ),
                          _ProfileSection(
                            title: "Education",
                            children: education.map((exp) => _ExperienceCard(exp: exp)).toList(),
                          ),
                          const _ProfileSection(
                            title: "Skills & Experience",
                            children: [
                              BulletList([
                                "Design databases and APIs",
                                "Design responsive websites and PWAs",
                                "Set up and maintain web servers",
                                "Maintain and integrate new system functionalities",
                                "Improve website performance",
                                "Integrate with external APIs (payment, messaging, etc.)",
                                "Implement Push and Web Notifications",
                                "Implement Secure authentication (custom and OAuth)",
                                "Develop functional and lightweight mobile apps",
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              const SliverFillRemaining(hasScrollBody: false, child: SizedBox(height: 0)),
            ],
          ),
        ),
      ),
    );
  }

  void _snapHeader({required bool delayed}) {
    if (_isSnapping) {
      return;
    }

    final double current = _scrollController.offset;
    final double max = _header!.maxExtent - _header!.minExtent;

    if (current <= 0 || current >= max) {
      return;
    }

    final double target = current < (max / 2) ? 0 : max;

    if (delayed) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _snapHeaderAnimation(target));
    } else {
      _snapHeaderAnimation(target);
    }
  }

  void _snapHeaderAnimation(double target) {
    if (!_scrollController.hasClients) return;

    _isSnapping = true;

    _scrollController
        .animateTo(target, duration: const Duration(milliseconds: 200), curve: Curves.easeOutCubic)
        .then((_) => _isSnapping = false)
        .catchError((_) => _isSnapping = false);
  }
}

class _ProfileDescription extends StatelessWidget {
  const _ProfileDescription();

  @override
  Widget build(BuildContext context) {
    return const TextCard(
      Text.rich(
        TextSpan(
          text: "A ",
          style: AppTextStyles.text,
          children: [
            TextSpan(
              text: "fast learner",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text:
                  " full-stack developer, driven by a passion for coding and finding efficient ways of solving problems. With ",
            ),
            TextSpan(
              text: "4 years of experience",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text:
                  " as a full-stack developer, using a variety of languages and working together with team members and clients to build and maintain systems. Currently enrolled in a two-year ",
            ),
            TextSpan(
              text: "Computer Information Systems",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: " diploma at Holland College."),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h2),
        ...children,
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience exp;

  const _ExperienceCard({required this.exp});

  @override
  Widget build(BuildContext context) {
    return TextCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: AppTextStyles.text,
              children: [
                TextSpan(
                  text: exp.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: " ${exp.place} ${exp.period}"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(exp.description, style: AppTextStyles.text),
          const SizedBox(height: 8),
          BulletList(exp.skills, horizontal: true),
        ],
      ),
    );
  }
}
