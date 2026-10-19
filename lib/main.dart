
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const TngReplicaApp());
}

const Color tngBlue = Color(0xFF0064D9);
const Color tngDarkBlue = Color(0xFF073B9A);
const Color pageBg = Color(0xFFF7F8FD);
const Color textDark = Color(0xFF252830);
const Color textMuted = Color(0xFF697386);

class TngReplicaApp extends StatelessWidget {
  const TngReplicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TNG eWallet Simulator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: tngBlue),
        fontFamily: 'Roboto',
      ),
      home: const TngHomePage(),
    );
  }
}

class ServiceItem {
  final String title;
  final IconData icon;
  final Color color;

  const ServiceItem(this.title, this.icon, this.color);
}

const List<ServiceItem> mainServices = [
  ServiceItem('GOfinance', Icons.savings_rounded, Color(0xFFFF9C16)),
  ServiceItem('Near Me', Icons.restaurant_rounded, Color(0xFFFFA726)),
  ServiceItem('Bil', Icons.receipt_long_rounded, Color(0xFF7250E8)),
  ServiceItem('Pengangkutan', Icons.train_rounded, Color(0xFF09B9D8)),
];

const List<ServiceItem> recommendedServices = [
  ServiceItem('Pengiriman', Icons.near_me_rounded, Color(0xFF1766B8)),
  ServiceItem('Kad Visa', Icons.credit_card_rounded, Color(0xFF1766B8)),
  ServiceItem('Internatio...', Icons.public_rounded, Color(0xFF1766B8)),
  ServiceItem('Global Ser...', Icons.language_rounded, Color(0xFFD83B49)),
];

const List<ServiceItem> favoriteServices = [
  ServiceItem('Refer & ea...', Icons.card_giftcard_rounded, Color(0xFF1766B8)),
  ServiceItem('MY Praba...', Icons.phone_android_rounded, Color(0xFF1766B8)),
  ServiceItem('e-Mas', Icons.diamond_rounded, Color(0xFF1766B8)),
  ServiceItem('Promo Ha...', Icons.local_offer_rounded, Color(0xFFE94B9A)),
  ServiceItem('redBus', Icons.directions_bus_rounded, Color(0xFFD94856)),
  ServiceItem('SOS Top up', Icons.sos_rounded, Color(0xFF1766B8)),
  ServiceItem('Tol', Icons.toll_rounded, Color(0xFF1766B8)),
  ServiceItem('Lagi', Icons.more_horiz_rounded, Color(0xFF1766B8)),
];

class TngHomePage extends StatefulWidget {
  const TngHomePage({super.key});

  @override
  State<TngHomePage> createState() => _TngHomePageState();
}

class _TngHomePageState extends State<TngHomePage> {
  int _tab = 0;
  bool _hideBalance = true;
  bool _editingFavorites = false;
  String _search = '';
  final Set<String> _favorites = {
    'Refer & ea...',
    'MY Praba...',
    'e-Mas',
    'Promo Ha...',
    'redBus',
    'SOS Top up',
    'Tol',
    'Lagi',
  };

  final PageController _bannerController = PageController();
  int _bannerIndex = 0;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _openPage(String title, {IconData icon = Icons.apps_rounded}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocalFeaturePage(title: title, icon: icon),
      ),
    );
  }

  void _onTab(int index) {
    if (index == 2) {
      _openPage('Scan QR', icon: Icons.qr_code_scanner_rounded);
      return;
    }
    setState(() => _tab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _tab,
          children: [
            _dashboard(),
            const LocalTabPage(
              title: 'Pindah',
              subtitle: 'Pindahan wang secara simulasi',
              icon: Icons.send_rounded,
            ),
            const SizedBox.shrink(),
            const LocalTabPage(
              title: 'Aktiviti',
              subtitle: 'Sejarah aktiviti simulasi',
              icon: Icons.receipt_long_rounded,
            ),
            const LocalTabPage(
              title: 'Profil',
              subtitle: 'Tetapan profil simulasi',
              icon: Icons.account_circle_rounded,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _dashboard() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _header()),
        SliverToBoxAdapter(child: _mainMenu()),
        SliverToBoxAdapter(child: _quickInfo()),
        SliverToBoxAdapter(child: _promotions()),
        SliverToBoxAdapter(child: _recommended()),
        SliverToBoxAdapter(child: _favoritesSection()),
        SliverToBoxAdapter(child: _financeSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5528DB),
            Color(0xFF087CEB),
            Color(0xFF152A8B),
            Color(0xFF21115F),
          ],
          stops: [0, 0.42, 0.72, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -85,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(.22),
                  width: 2,
                ),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFB53DF2).withOpacity(.5),
                    const Color(0xFF159BFA).withOpacity(.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    '01:40  ◉  ◌  •',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.signal_cellular_alt,
                      color: Colors.white, size: 17),
                  const SizedBox(width: 5),
                  const Icon(Icons.wifi, color: Colors.white, size: 17),
                  const SizedBox(width: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '68',
                      style: TextStyle(
                        color: textDark,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.18),
                      border: Border.all(color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Text('🇲🇾', style: TextStyle(fontSize: 19)),
                        SizedBox(width: 8),
                        Text(
                          'MY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.location_city,
                            color: Colors.white70, size: 22),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.black38),
                          const SizedBox(width: 7),
                          Expanded(
                            child: TextField(
                              onChanged: (v) => setState(() => _search = v),
                              decoration: const InputDecoration(
                                hintText: 'Kembangkan duit',
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0C9),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Text(
                              '🟡 Bijak jimat',
                              style: TextStyle(
                                color: Color(0xFF378C3D),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Jumlah Baki',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 7),
                            InkWell(
                              onTap: () =>
                                  setState(() => _hideBalance = !_hideBalance),
                              child: Icon(
                                _hideBalance
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Text(
                              _hideBalance ? 'RM ****' : 'RM 0.00',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 29,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.verified_user_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _openPage(
                      'Tambah nilai',
                      icon: Icons.add_card_rounded,
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                    child: const Row(
                      children: [
                        Text('Tambah nilai'),
                        SizedBox(width: 5),
                        Icon(Icons.chevron_right, size: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainMenu() {
    return Transform.translate(
      offset: const Offset(0, -1),
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 15,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          children: mainServices.map((service) {
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _openPage(service.title, icon: service.icon),
                child: Column(
                  children: [
                    Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                        color: service.color.withOpacity(.10),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(service.icon,
                          size: 40, color: service.color),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _quickInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Row(
        children: [
          Expanded(
            child: _infoCard(
              icon: Icons.savings_rounded,
              color: const Color(0xFFFFB21D),
              title: 'Jom tambah duit',
              subtitle: 'Mula dari RM10 sah...',
              onTap: () => _openPage('Jom tambah duit',
                  icon: Icons.savings_rounded),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _infoCard(
              icon: Icons.card_giftcard_rounded,
              color: const Color(0xFF2188DD),
              title: 'GOrewards',
              subtitle: '6,401 mata',
              onTap: () => _openPage('GOrewards',
                  icon: Icons.card_giftcard_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFE9F0FF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promotions() {
    final banners = [
      const _BannerData(
        label: 'Pinduoduo',
        title: 'Belanja barang murah dari China!',
        subtitle: 'Pakai TNG eWallet, tanpa ribet!',
        color: Color(0xFF092E9D),
        icon: Icons.shopping_bag_rounded,
      ),
      const _BannerData(
        label: 'GOfinance  |  Remittance',
        title: 'Ajak teman pakai Remittance',
        subtitle: 'Dapatkan hingga RM125!',
        color: Color(0xFFB5E7EF),
        icon: Icons.flight_takeoff_rounded,
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 138,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (i) => setState(() => _bannerIndex = i),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: banner.color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banner.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: index == 0
                                  ? Colors.white70
                                  : const Color(0xFF4D338B),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            banner.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  index == 0 ? Colors.white : textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  index == 0 ? Colors.white : textDark,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        banner.icon,
                        color: index == 0
                            ? Colors.white
                            : const Color(0xFF6941B7),
                        size: 65,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _bannerIndex == index ? 22 : 9,
              height: 9,
              decoration: BoxDecoration(
                color: _bannerIndex == index
                    ? tngBlue
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }

  Widget _recommended() {
    final filtered = recommendedServices.where((s) {
      return s.title.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Disyorkan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          Row(
            children: filtered.map((service) {
              return Expanded(
                child: InkWell(
                  onTap: () =>
                      _openPage(service.title, icon: service.icon),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Column(
                      children: [
                        Icon(service.icon,
                            size: 47, color: service.color),
                        const SizedBox(height: 8),
                        Text(
                          service.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF4E5667),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _favoritesSection() {
    final services = favoriteServices
        .where((s) => _favorites.contains(s.title))
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Kegemaran Saya',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () =>
                    setState(() => _editingFavorites = !_editingFavorites),
                child: Text(_editingFavorites ? 'Selesai' : 'Edit'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 4,
              childAspectRatio: .9,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              return InkWell(
                onTap: () {
                  if (_editingFavorites) {
                    setState(() => _favorites.remove(service.title));
                  } else {
                    _openPage(service.title, icon: service.icon);
                  }
                },
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(service.icon,
                            size: 43, color: service.color),
                        if (_editingFavorites)
                          const Positioned(
                            right: -8,
                            top: -8,
                            child: Icon(Icons.remove_circle,
                                size: 18, color: Colors.red),
                          ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      service.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4E5667),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _financeSection() {
    final financeItems = [
      ('Dapat duit lebih', Icons.savings_rounded),
      ('Banding insurans', Icons.verified_user_rounded),
      ('Bayar di luar negara', Icons.public_rounded),
      ('Kirim wang', Icons.currency_exchange_rounded),
      ('Labur wang anda', Icons.bar_chart_rounded),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
      color: const Color(0xFFFFF8E3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'GOfinance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    _openPage('GOfinance', icon: Icons.savings_rounded),
                child: const Text('Buka ❯'),
              ),
            ],
          ),
          const Text(
            'Kembangkan dan lindungi wang anda.',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 94,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: financeItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = financeItems[index];
                return InkWell(
                  onTap: () => _openPage(item.$1, icon: item.$2),
                  child: Container(
                    width: 190,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.$1,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Icon(item.$2, color: tngBlue, size: 37),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    const labels = ['Utama', 'Pindah', '', 'Aktiviti', 'Profil'];
    const icons = [
      Icons.home_filled,
      Icons.send_outlined,
      Icons.qr_code_scanner_rounded,
      Icons.receipt_long_outlined,
      Icons.account_circle_outlined,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 78,
          child: Row(
            children: List.generate(5, (index) {
              if (index == 2) {
                return Expanded(
                  child: Center(
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => _onTab(2),
                        child: Container(
                          width: 66,
                          height: 66,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF16C5E9),
                                Color(0xFF3C78F5),
                                Color(0xFFAE53EF),
                              ],
                            ),
                          ),
                          child: Icon(
                            icons[index],
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              final selected = _tab == index;
              return Expanded(
                child: InkWell(
                  onTap: () => _onTab(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 27,
                        color: selected
                            ? const Color(0xFF29445C)
                            : const Color(0xFF697786),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selected
                              ? const Color(0xFF29445C)
                              : const Color(0xFF697786),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BannerData {
  final String label;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _BannerData({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });
}

class LocalTabPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const LocalTabPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const SizedBox(height: 25),
        Text(title,
            style: const TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold)),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF087CEB), Color(0xFF4825C9)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 58),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _NoticeCard(
          icon: Icons.info_outline,
          title: 'Mod simulasi',
          text: 'Halaman ini hanya untuk demonstrasi UI. '
              'Tiada wang sebenar dipindahkan atau dicaj.',
        ),
      ],
    );
  }
}

class LocalFeaturePage extends StatefulWidget {
  final String title;
  final IconData icon;

  const LocalFeaturePage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  State<LocalFeaturePage> createState() => _LocalFeaturePageState();
}

class _LocalFeaturePageState extends State<LocalFeaturePage> {
  final TextEditingController _amountController = TextEditingController();
  String _message = '';
  String _selectedMethod = 'Kad bank simulasi';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  bool get _isTopUp =>
      widget.title.toLowerCase().contains('tambah nilai');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: pageBg,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF087CEB), Color(0xFF4925C7)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Icon(widget.icon, size: 52, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Simulasi lokal sahaja',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (_isTopUp) ...[
            const Text(
              'Jumlah tambah nilai (RM)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixText: 'RM ',
                hintText: 'Contoh: 10.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Kaedah simulasi',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Kad bank simulasi',
                  child: Text('Kad bank simulasi'),
                ),
                DropdownMenuItem(
                  value: 'Online banking simulasi',
                  child: Text('Online banking simulasi'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedMethod = value);
                }
              },
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                final amount = double.tryParse(
                  _amountController.text.trim(),
                );
                setState(() {
                  _message = amount == null || amount <= 0
                      ? 'Masukkan jumlah yang sah.'
                      : 'Simulasi berjaya: RM ${amount.toStringAsFixed(2)} '
                          'melalui $_selectedMethod. '
                          'Baki sebenar tidak berubah.';
                });
              },
              child: const Text('Pratonton simulasi'),
            ),
          ] else ...[
            const _NoticeCard(
              icon: Icons.touch_app_rounded,
              title: 'Halaman interaktif',
              text: 'Ini ialah halaman demonstrasi. '
                  'Tiada sambungan ke akaun atau sistem pembayaran.',
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () => setState(() {
                _message = 'Anda menekan butang simulasi untuk '
                    '${widget.title}. Tiada transaksi sebenar berlaku.';
              }),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Cuba interaksi'),
            ),
          ],
          if (_message.isNotEmpty) ...[
            const SizedBox(height: 18),
            _NoticeCard(
              icon: Icons.check_circle_outline,
              title: 'Hasil simulasi',
              text: _message,
            ),
          ],
          const SizedBox(height: 18),
          const _NoticeCard(
            icon: Icons.shield_outlined,
            title: 'Demo sahaja',
            text: 'Semua tindakan di sini adalah lokal. '
                'Tiada wang sebenar dipindahkan, ditambah atau dicaj.',
          ),
        ],
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _NoticeCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tngBlue, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: const TextStyle(
                    color: textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
