import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  void _openHumidityArticle() async {
    const url = 'https://www.cge48.ru/gigienicheskoe-vospitanie-i-obuchenie/informaciya-dlya-naseleniya/1447.htm';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О разработчике'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/developer.jpg'), // Добавьте свое фото
              child: Icon(Icons.person, size: 50), // Заглушка если нет фото
            ),
            const SizedBox(height: 20),
            const Text(
              'Тихонов Дмитрий Сергеевич',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Группа: ВМК-22',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              'Контактная информация',
              Icons.contact_mail,
              [
                'Email: dtihonov@mail.ru',
                'Телефон: +7 (914) 805 ** **',
                'GitHub: github.com//DmitryBaLaBoL',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'О приложении',
              Icons.info,
              [
                'Погодное приложение с расчетом комфортности влажности',
                'Хранение истории в Hive',
                'Дополнительные функции расчета',
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openHumidityArticle,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Статья о влиянии влажности'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<String> items) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('• $item'),
            )),
          ],
        ),
      ),
    );
  }
}