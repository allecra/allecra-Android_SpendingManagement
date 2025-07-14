# ỨNG DỤNG QUẢN LÝ CHI TIÊU CÁ NHÂN

## 1.1 Thông tin dự án
- **Tên tiếng Anh:** Personal Expense Management
- **Tên tiếng Việt:** Quản lý chi tiêu cá nhân
- **Mã dự án:** PEM
- **Loại phần mềm:** App

## 1.2 Thành viên tham gia
| Tên                   | Mã sinh viên | Gmail                  |
|-----------------------|--------------|------------------------|
| Nguyễn Thị Thanh Ngân | BIT230287    | nttngan1606@gmail.com  |
| Nguyễn Thị Tâm        | BIT230372    | tam2632005@gmail.com   |
| Hoàng Minh Thiện      | BIT230390    | thienkt179@gmail.com   |

---

## 2. Giới thiệu
Ứng dụng giúp người dùng quản lý chi tiêu cá nhân một cách dễ dàng, trực quan, hỗ trợ thống kê, phân loại thu chi, và lưu trữ dữ liệu an toàn trên Firebase.

### Tính năng chính
- Đăng ký, đăng nhập bằng Email/Password (Firebase Auth)
- Quản lý thu chi, phân loại chi tiêu
- Thống kê, biểu đồ chi tiêu theo ngày/tháng/năm
- Lưu trữ dữ liệu trên Firebase Firestore
- Hỗ trợ đa ngôn ngữ (Tiếng Việt, Tiếng Anh)
- Giao diện hiện đại, dễ sử dụng

---

## 3. Hướng dẫn cài đặt & sử dụng

### 3.1 Clone project
```sh
git clone https://github.com/allecra/Android_SpendingManagement.git
cd Android_SpendingManagement
```

### 3.2 Cài đặt dependencies
```sh
flutter pub get
```

### 3.3 Cấu hình Firebase
- Thay file `android/app/google-services.json` và `ios/Runner/GoogleService-Info.plist` bằng file của project Firebase của bạn (nếu muốn dùng Firebase riêng).
- Đảm bảo đã bật Authentication (Email/Password) và tạo Firestore Database trên Firebase Console.

### 3.4 Chạy app
```sh
flutter run
```

---

## 4. Thông tin thêm
- Project sử dụng Flutter, Firebase, Bloc, Firestore, v.v.
- Nếu gặp lỗi về version package, hãy kiểm tra lại các ràng buộc trong `pubspec.yaml` và cập nhật cho phù hợp với version Flutter bạn đang dùng.

---

## 5. Liên hệ
- Tác giả: Nhóm PEM
- Github: [allecra/Android_SpendingManagement](https://github.com/allecra/Android_SpendingManagement)
