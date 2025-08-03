# 📱 Dume - Ứng dụng Quản lý Chi tiêu Cá nhân

## 🚀 Tính năng chính

### 👤 **Quản lý tài khoản**
- ✅ Đăng ký/Đăng nhập với Firebase Authentication
- ✅ Xác thực email
- ✅ Quên mật khẩu
- ✅ Hồ sơ người dùng với avatar, thông tin cá nhân
- ✅ Đổi mật khẩu
- ✅ Đa ngôn ngữ (Tiếng Việt/English)
- ✅ Chế độ tối/sáng

### 💰 **Quản lý chi tiêu**
- ✅ Thêm chi tiêu với hình ảnh, ghi chú, địa điểm
- ✅ Chia sẻ chi tiêu với bạn bè
- ✅ Chọn loại chi tiêu (ăn uống, di chuyển, mua sắm...)
- ✅ Chọn ngày chi tiêu
- ✅ Sửa/Xóa chi tiêu
- ✅ Validation chi tiết (giới hạn số tiền, ký tự...)

### 📊 **Phân tích & Báo cáo**
- ✅ Biểu đồ cột theo ngày
- ✅ Biểu đồ tròn theo loại chi tiêu
- ✅ Tổng hợp chi tiêu theo tháng
- ✅ So sánh với hạn mức
- ✅ Xuất dữ liệu CSV

### 📅 **Lịch & Tìm kiếm**
- ✅ Lịch chi tiêu theo ngày
- ✅ Tìm kiếm chi tiêu theo:
  - Ngày cụ thể
  - Tháng
  - Loại chi tiêu
  - Từ khóa
- ✅ Lọc và sắp xếp kết quả

### 🤖 **AI Chatbot hỗ trợ**
- ✅ Tích hợp Google Gemini AI
- ✅ Truy cập dữ liệu chi tiêu thực tế
- ✅ Tư vấn tài chính cá nhân
- ✅ Nhắc nhở hạn mức
- ✅ Phân tích xu hướng chi tiêu

### 💳 **Quản lý ví & Hạn mức**
- ✅ Thiết lập hạn mức chi tiêu hàng tháng
- ✅ Theo dõi thu nhập
- ✅ Cảnh báo vượt hạn mức
- ✅ Thống kê thu chi

### 🔔 **Thông báo & UX**
- ✅ Toast/SnackBar cho tất cả thao tác
- ✅ Thông báo chào mừng khi mở app
- ✅ Loading animation
- ✅ Responsive design
- ✅ Dark/Light theme

## 🗄️ Cấu trúc Database (Firestore)

### **Collection: `spending`**
```json
{
  "id": "string",
  "date": "timestamp", 
  "friends": ["array"],
  "image": "string",
  "location": "string",
  "money": "number",
  "note": "string", 
  "type": "string",
  "fullname": "string"
}
```

### **Collection: `info`**
```json
{
  "id": "string",
  "name": "string",
  "money": "number",
  "avatar": "string", 
  "gender": "boolean",
  "birthday": "string",
  "userId": "string"
}
```

### **Collection: `wallet`**
```json
{
  "userId": "string",
  "01_2024": "number",  // Format: MM_YYYY
  "02_2024": "number",
  // ... các tháng khác
}
```

### **Collection: `data`**
```json
{
  "userId": "string", 
  "01_2024": ["spending_id_1", "spending_id_2"],  // List ID spending theo tháng
  "02_2024": ["spending_id_3", "spending_id_4"],
  // ... các tháng khác
}
```

## 🔧 Công nghệ sử dụng

- **Frontend**: Flutter 3.x
- **Backend**: Firebase
  - Authentication
  - Firestore Database  
  - Storage (hình ảnh)
- **AI**: Google Gemini API
- **State Management**: BLoC Pattern
- **Localization**: Flutter Intl
- **UI/UX**: Material Design 3

## 📱 Màn hình chính

1. **Trang chủ**: Tổng quan chi tiêu ngày hôm nay
2. **Lịch**: Xem chi tiêu theo lịch + nút tìm kiếm
3. **Phân tích**: Biểu đồ và báo cáo chi tiết
4. **Tài khoản**: Quản lý hồ sơ và cài đặt

## 🎯 Điểm nổi bật

- ✅ **Bảo mật**: Firebase Authentication + Security Rules
- ✅ **Real-time**: Cập nhật dữ liệu theo thời gian thực
- ✅ **AI-powered**: Chatbot thông minh với dữ liệu thực
- ✅ **User-friendly**: Giao diện đẹp, dễ sử dụng
- ✅ **Multi-language**: Hỗ trợ đa ngôn ngữ
- ✅ **Offline-ready**: Cache dữ liệu local
- ✅ **Responsive**: Tương thích nhiều kích thước màn hình

## 🚀 Cài đặt & Chạy

1. Clone repository
2. `flutter pub get`
3. Cấu hình Firebase
4. `flutter run`

## 📄 License

MIT License
