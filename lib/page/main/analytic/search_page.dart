import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/constants/function/route_function.dart';
import 'package:spending_management/constants/list.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/view_spending/view_spending_page.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Spending> _searchResults = [];
  bool _isLoading = false;
  String _selectedFilter = 'all'; // all, date, month, type
  DateTime? _selectedDate;
  String? _selectedMonth;
  int? _selectedType;
  
  final List<String> _months = [
    '01_2024', '02_2024', '03_2024', '04_2024', '05_2024', '06_2024',
    '07_2024', '08_2024', '09_2024', '10_2024', '11_2024', '12_2024',
    '01_2025', '02_2025', '03_2025', '04_2025', '05_2025', '06_2025',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('search')),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm chi tiêu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => _performSearch(),
            ),
          ),
          
          // Filter Options
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFilter,
                    decoration: InputDecoration(
                      labelText: 'Bộ lọc',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'all', child: Text('Tất cả')),
                      DropdownMenuItem(value: 'date', child: Text('Theo ngày')),
                      DropdownMenuItem(value: 'month', child: Text('Theo tháng')),
                      DropdownMenuItem(value: 'type', child: Text('Theo loại')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value!;
                        _clearSearch();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                if (_selectedFilter == 'date')
                  Expanded(
                    child: InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(_selectedDate != null 
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                              : 'Chọn ngày'),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (_selectedFilter == 'month')
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMonth,
                      decoration: InputDecoration(
                        labelText: 'Tháng',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _months.map((month) {
                        final parts = month.split('_');
                        return DropdownMenuItem(
                          value: month,
                          child: Text('${parts[0]}/${parts[1]}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value;
                          _performSearch();
                        });
                      },
                    ),
                  ),
                if (_selectedFilter == 'type')
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        labelText: 'Loại',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: listType.asMap().entries.map((entry) {
                        final title = entry.value['title'];
                        if (title == null) return null;
                        try {
                          final translatedTitle = AppLocalizations.of(context).translate(title);
                          return DropdownMenuItem(
                            value: entry.key,
                            child: Text(translatedTitle),
                          );
                        } catch (e) {
                          // Nếu không tìm thấy key trong file ngôn ngữ, dùng title gốc
                          return DropdownMenuItem(
                            value: entry.key,
                            child: Text(title),
                          );
                        }
                      }).where((item) => item != null).cast<DropdownMenuItem<int>>().toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                          _performSearch();
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Search Results
          Expanded(
            child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Không tìm thấy kết quả',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final spending = _searchResults[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: Image.asset(
                            listType[spending.type]?["image"] ?? "assets/icons/question_mark.png",
                            width: 40,
                          ),
                          title: Text(
                            spending.type == 41
                                ? (spending.typeName ?? "Không xác định")
                                : (() {
                                    try {
                                      final title = listType[spending.type]?["title"] ?? "unknown";
                                      return AppLocalizations.of(context).translate(title);
                                    } catch (e) {
                                      return "Không xác định";
                                    }
                                  })(),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (spending.note != null && spending.note!.isNotEmpty)
                                Text(spending.note!),
                              Text(
                                DateFormat('dd/MM/yyyy HH:mm').format(spending.dateTime),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          trailing: Text(
                            NumberFormat.currency(locale: "vi_VI").format(spending.money),
                            style: TextStyle(
                              color: spending.money > 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              createRoute(
                                screen: ViewSpendingPage(spending: spending),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _performSearch();
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchResults.clear();
      _selectedDate = null;
      _selectedMonth = null;
      _selectedType = null;
    });
  }

  void _performSearch() async {
    if (_searchController.text.isEmpty && 
        _selectedFilter == 'all' && 
        _selectedDate == null && 
        _selectedMonth == null && 
        _selectedType == null) {
      _clearSearch();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      List<Spending> allSpending = [];
      
      // Lấy tất cả dữ liệu chi tiêu
      final dataDoc = await FirebaseFirestore.instance
          .collection("data")
          .doc(user.uid)
          .get();
      
      if (dataDoc.exists) {
        final data = dataDoc.data() as Map<String, dynamic>?;
        if (data == null) return;
        
        for (var monthKey in data.keys) {
          if (_selectedFilter == 'month' && _selectedMonth != null && monthKey != _selectedMonth) {
            continue;
          }
          
          final monthData = data[monthKey];
          if (monthData == null || monthData is! List) continue;
          
          List<String> listId = (monthData as List<dynamic>).map((e) => e.toString()).toList();
          
          for (var id in listId) {
            final doc = await FirebaseFirestore.instance.collection("spending").doc(id).get();
            if (doc.exists) {
              try {
                final spending = Spending.fromFirebase(doc);
                
                // Lọc theo điều kiện
                bool shouldInclude = true;
                
                // Lọc theo từ khóa
                if (_searchController.text.isNotEmpty) {
                  final searchText = _searchController.text.toLowerCase();
                  final note = spending.note?.toLowerCase() ?? '';
                  final typeName = spending.typeName?.toLowerCase() ?? '';
                  String typeTitle = '';
                  try {
                    final title = listType[spending.type]?["title"] ?? "unknown";
                    typeTitle = AppLocalizations.of(context).translate(title).toLowerCase();
                  } catch (e) {
                    typeTitle = "không xác định";
                  }
                  
                  if (!note.contains(searchText) && 
                      !typeName.contains(searchText) && 
                      !typeTitle.contains(searchText)) {
                    shouldInclude = false;
                  }
                }
                
                // Lọc theo ngày
                if (_selectedFilter == 'date' && _selectedDate != null) {
                  final spendingDate = DateTime(spending.dateTime.year, spending.dateTime.month, spending.dateTime.day);
                  final selectedDate = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
                  if (spendingDate != selectedDate) {
                    shouldInclude = false;
                  }
                }
                
                // Lọc theo loại
                if (_selectedFilter == 'type' && _selectedType != null) {
                  if (spending.type != _selectedType) {
                    shouldInclude = false;
                  }
                }
                
                if (shouldInclude) {
                  allSpending.add(spending);
                }
              } catch (e) {
                print('Lỗi khi parse spending: $e');
                continue;
              }
            }
          }
        }
      }
      
      // Sắp xếp theo thời gian mới nhất
      allSpending.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      
      setState(() {
        _searchResults = allSpending;
        _isLoading = false;
      });
    } catch (e) {
      print('Lỗi khi tìm kiếm: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
