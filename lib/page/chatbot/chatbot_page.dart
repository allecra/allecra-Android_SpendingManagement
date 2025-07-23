import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/spending.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: 'user');
  final types.User _bot = const types.User(
    id: 'bot',
    firstName: 'DumeBot',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/4712/4712035.png',
  );
  final String _apiKey = 'AIzaSyBZKR-GJ8TyAKZryznTpcgFkCnywlJpTXg';
  bool _isLoading = false;

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
    await _sendToChatGPT(message.text);
  }

  Future<void> _sendToChatGPT(String prompt) async {
    setState(() => _isLoading = true);
    try {
      String spendingSummary = await _getUserSpendingSummary();
      final url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey';
      final requestBody = {
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": "Bạn là trợ lý tài chính cá nhân, hãy trả lời các câu hỏi về chi tiêu dựa trên dữ liệu sau: $spendingSummary"}
            ]
          },
          {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      log('Gemini response status: ${response.statusCode}');
      log('Gemini response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String content = '';
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final parts = data['candidates'][0]['content']['parts'];
          if (parts != null && parts.isNotEmpty) {
            content = parts[0]['text'] ?? '';
          }
        }
        if (content.isEmpty) {
          content = 'Xin lỗi, tôi không thể trả lời lúc này. Vui lòng thử lại sau.';
        }
        final botMessage = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: content.trim(),
        );
        _addMessage(botMessage);
      } else {
        final botMessage = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'Xin lỗi, tôi không thể trả lời lúc này. Vui lòng thử lại sau.',
        );
        _addMessage(botMessage);
      }
    } catch (e, stack) {
      log('Lỗi khi gửi tới Gemini: ${e.toString()}');
      log(stack.toString());
      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Xin lỗi, tôi không thể trả lời lúc này. Vui lòng thử lại sau.',
      );
      _addMessage(botMessage);
    }
    setState(() => _isLoading = false);
  }

  Future<String> _getUserSpendingSummary() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'Không có dữ liệu người dùng.';
      final now = DateTime.now();
      final monthKey = "${now.month.toString().padLeft(2, '0')}_${now.year}";
      final dataDoc = await FirebaseFirestore.instance
          .collection("data")
          .doc(user.uid)
          .get();
      final data = dataDoc.data() as Map<String, dynamic>?;
      if (data == null || data[monthKey] == null) {
        return 'Bạn chưa có chi tiêu nào trong tháng này.';
      }
      List<String> listId = (data[monthKey] as List<dynamic>).map((e) => e.toString()).toList();
      List<Spending> spendingList = [];
      for (var id in listId) {
        final doc = await FirebaseFirestore.instance.collection("spending").doc(id).get();
        if (doc.exists) {
          spendingList.add(Spending.fromFirebase(doc));
        }
      }
      if (spendingList.isEmpty) {
        return 'Bạn chưa có chi tiêu nào trong tháng này.';
      }
      int total = spendingList.fold(0, (sum, item) => sum + item.money);
      final walletDoc = await FirebaseFirestore.instance
          .collection("wallet")
          .doc(user.uid)
          .get();
      int wallet = 0;
      if (walletDoc.exists) {
        final walletData = walletDoc.data() as Map<String, dynamic>?;
        if (walletData != null && walletData[monthKey] != null) {
          wallet = walletData[monthKey] is int ? walletData[monthKey] : int.tryParse(walletData[monthKey].toString()) ?? 0;
        }
      }
      spendingList.sort((a, b) => b.money.compareTo(a.money));
      var topSpending = spendingList.take(3).toList();
      String topStr = topSpending.map((e) => "${e.typeName ?? e.type}: ${e.money}đ").join(", ");
      log('Tổng chi: $total, hạn mức: $wallet, top: $topStr');
      return "Tổng chi tháng này: ${total}đ, hạn mức: ${wallet}đ, các khoản lớn: $topStr.";
    } catch (e, stack) {
      log('Lỗi khi lấy dữ liệu chi tiêu: ${e.toString()}');
      log(stack.toString());
      return 'Không lấy được dữ liệu chi tiêu.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(_bot.imageUrl!),
            ),
            const SizedBox(width: 10),
            const Text('DumeBot - Trợ lý chi tiêu'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            showUserAvatars: true,
            showUserNames: true,
          ),
          if (_isLoading)
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
} 