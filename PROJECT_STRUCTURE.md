# 📁 Cấu trúc Project Dume

```
dume/
├── 📱 android/                    # Cấu hình Android
│   ├── app/
│   │   ├── build.gradle.kts      # Build config Android
│   │   ├── google-services.json   # Firebase config
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  # App permissions
│   │       └── kotlin/
│   │           └── MainActivity.kt   # Entry point Android
│   └── build.gradle.kts
│
├── 🍎 ios/                        # Cấu hình iOS
│   ├── Runner/
│   │   ├── AppDelegate.swift      # Entry point iOS
│   │   ├── Info.plist            # App config iOS
│   │   └── Assets.xcassets/      # Icons & images iOS
│   └── Runner.xcodeproj/
│
├── 🎨 assets/                     # Tài nguyên static
│   ├── icons/                     # Icons cho categories
│   │   ├── armchair.png          # Furniture spending
│   │   ├── borrow.png            # Borrow/loan
│   │   ├── box.png               # Shopping
│   │   ├── card-payment.png      # Payment methods
│   │   ├── coins.png             # Money/currency
│   │   ├── commission.png        # Commission/fees
│   │   ├── diamond.png           # Luxury items
│   │   ├── doctor.png            # Healthcare
│   │   ├── eat.png               # Food & dining
│   │   ├── education.png         # Education
│   │   ├── electricity.png       # Utilities
│   │   ├── family.png            # Family expenses
│   │   ├── game-pad.png          # Entertainment
│   │   ├── gas.png               # Transportation
│   │   ├── give-love.png         # Gifts/donations
│   │   ├── health-insurance.png  # Insurance
│   │   ├── house.png             # Housing
│   │   ├── internet.png          # Internet/tech
│   │   ├── loan.png              # Loans
│   │   ├── money.png             # General money
│   │   ├── pay.png               # Payments
│   │   ├── percentage.png        # Interest/fees
│   │   ├── pet.png               # Pet expenses
│   │   ├── phone.png             # Communication
│   │   ├── plus.png              # Add new
│   │   ├── question_mark.png     # Unknown category
│   │   ├── sports.png            # Sports/fitness
│   │   ├── stats.png             # Statistics
│   │   ├── taxi.png              # Transportation
│   │   ├── tools.png             # Tools/equipment
│   │   ├── toothbrush.png        # Personal care
│   │   ├── tv.png                # Entertainment
│   │   ├── wallet.png            # Wallet
│   │   └── water.png             # Utilities
│   │
│   ├── images/                    # UI images
│   │   ├── buy-me-a-coffee.png   # Support image
│   │   ├── email.png             # Email icon
│   │   ├── english.png           # English flag
│   │   ├── female.png            # Female avatar
│   │   ├── gmail.png             # Gmail icon
│   │   ├── male.png              # Male avatar
│   │   └── vietnam.png           # Vietnam flag
│   │
│   ├── intro/                     # Onboarding images
│   │   ├── add.jpg               # Add spending
│   │   ├── analytic.jpg          # Analytics
│   │   ├── calendar.jpg          # Calendar view
│   │   ├── home.jpg              # Home screen
│   │   ├── profile.jpg           # Profile
│   │   ├── search.jpg            # Search
│   │   └── share.jpg             # Share feature
│   │
│   ├── lang/                      # Localization files
│   │   ├── en.json               # English translations
│   │   └── vi.json               # Vietnamese translations
│   │
│   └── logo/                      # App branding
│       ├── google_logo.png       # Google logo
│       └── logo.png              # App logo
│
├── 🧩 lib/                        # Source code chính
│   ├── constants/                 # Constants & utilities
│   │   ├── app_colors.dart       # Color scheme
│   │   ├── app_styles.dart       # Text styles
│   │   ├── function/              # Utility functions
│   │   │   ├── extension.dart    # Dart extensions
│   │   │   ├── find_index.dart   # Array utilities
│   │   │   ├── get_data_spending.dart  # Data fetching
│   │   │   ├── get_date.dart     # Date utilities
│   │   │   ├── list_categories.dart    # Category lists
│   │   │   ├── loading_animation.dart  # Loading UI
│   │   │   ├── on_will_pop.dart  # Back button handling
│   │   │   ├── pick_function.dart      # Image picker
│   │   │   └── route_function.dart     # Navigation
│   │   └── list.dart             # Static lists
│   │
│   ├── controls/                  # Business logic
│   │   └── spending_firebase.dart # Firebase operations
│   │
│   ├── firebase_options.dart      # Firebase config
│   │
│   ├── main.dart                  # App entry point
│   │
│   ├── models/                    # Data models
│   │   ├── api_service.dart      # API service
│   │   ├── filter.dart           # Filter model
│   │   ├── spending.dart         # Spending model
│   │   └── user.dart             # User model
│   │
│   ├── page/                      # UI screens
│   │   ├── add_spending/         # Add spending flow
│   │   │   ├── add_friend_page.dart    # Add friends
│   │   │   ├── add_spending.dart       # Main add screen
│   │   │   ├── choose_type.dart        # Category picker
│   │   │   └── widget/                 # Add spending widgets
│   │   │       ├── add_friend.dart     # Friend selection
│   │   │       ├── circle_text.dart    # Circular text
│   │   │       ├── input_money.dart    # Money input
│   │   │       ├── input_spending.dart # Spending input
│   │   │       ├── item_spending.dart  # Spending item
│   │   │       ├── more_button.dart    # More options
│   │   │       ├── pick_image_widget.dart  # Image picker
│   │   │       └── remove_icon.dart    # Remove button
│   │   │
│   │   ├── edit_spending/        # Edit spending
│   │   │   └── edit_spending_page.dart # Edit screen
│   │   │
│   │   ├── forgot/               # Password recovery
│   │   │   ├── forgot_page.dart  # Forgot password
│   │   │   └── success_page.dart # Success screen
│   │   │
│   │   ├── login/                # Authentication
│   │   │   ├── bloc/             # Login state management
│   │   │   │   ├── login_bloc.dart     # Login logic
│   │   │   │   ├── login_event.dart    # Login events
│   │   │   │   └── login_state.dart    # Login states
│   │   │   ├── login_form.dart   # Login form
│   │   │   ├── login_page.dart   # Login screen
│   │   │   └── widget/           # Login widgets
│   │   │       ├── custom_button.dart  # Custom button
│   │   │       ├── input_password.dart # Password input
│   │   │       ├── input_text.dart     # Text input
│   │   │       └── text_continue.dart  # Continue text
│   │   │
│   │   ├── main/                 # Main app screens
│   │   │   ├── analytic/         # Analytics & reports
│   │   │   │   ├── analytic_page.dart  # Main analytics
│   │   │   │   ├── chart/        # Chart components
│   │   │   │   │   ├── column_chart.dart    # Bar chart
│   │   │   │   │   └── pie_chart.dart       # Pie chart
│   │   │   │   ├── function/     # Analytics functions
│   │   │   │   │   └── render_list_money.dart  # Money rendering
│   │   │   │   ├── search_page.dart     # Search functionality
│   │   │   │   └── widget/       # Analytics widgets
│   │   │   │       ├── box_text.dart    # Text boxes
│   │   │   │       ├── custom_tabbar.dart    # Custom tabs
│   │   │   │       ├── filter_page.dart      # Filter UI
│   │   │   │       ├── item_filter.dart      # Filter items
│   │   │   │       ├── item_spending_day.dart # Daily spending
│   │   │   │       ├── my_search_delegate.dart # Search delegate
│   │   │   │       ├── show_date.dart        # Date display
│   │   │   │       ├── show_list_spending_column.dart  # Column list
│   │   │   │       ├── show_list_spending_pie.dart     # Pie list
│   │   │   │       ├── tabbar_chart.dart     # Chart tabs
│   │   │   │       ├── tabbar_type.dart      # Type tabs
│   │   │   │       └── total_report.dart     # Total reports
│   │   │   │
│   │   │   ├── calendar/         # Calendar view
│   │   │   │   ├── calendar_page.dart        # Calendar screen
│   │   │   │   └── widget/       # Calendar widgets
│   │   │   │       ├── build_spending.dart   # Spending builder
│   │   │   │       ├── custom_table_calendar.dart  # Custom calendar
│   │   │   │       └── total_spending.dart   # Total spending
│   │   │   │
│   │   │   ├── home/             # Home screen
│   │   │   │   ├── day_month.dart           # Date display
│   │   │   │   ├── home_page.dart           # Main home
│   │   │   │   ├── view_list_spending_page.dart  # Spending list
│   │   │   │   └── widget/       # Home widgets
│   │   │   │       ├── item_spending_day.dart     # Daily items
│   │   │   │       ├── item_spending_widget.dart  # Spending widget
│   │   │   │       └── summary_spending.dart      # Spending summary
│   │   │   │
│   │   │   ├── main_page.dart    # Main navigation
│   │   │   │
│   │   │   ├── profile/          # User profile
│   │   │   │   ├── about_page.dart        # About app
│   │   │   │   ├── change_password.dart   # Password change
│   │   │   │   ├── currency_exchange_rate.dart  # Exchange rates
│   │   │   │   ├── edit_profile_page.dart # Profile editor
│   │   │   │   ├── history_page.dart      # Transaction history
│   │   │   │   ├── new_password.dart      # New password
│   │   │   │   ├── profile_page.dart      # Profile screen
│   │   │   │   └── widget/       # Profile widgets
│   │   │   │       ├── info_widget.dart   # User info
│   │   │   │       ├── setting_item.dart  # Settings item
│   │   │   │       └── show_birthday.dart # Birthday display
│   │   │   │
│   │   │   └── widget/           # Shared widgets
│   │   │       ├── custom_tabbar.dart     # Custom tabs
│   │   │       ├── input_income.dart      # Income input
│   │   │       ├── input_spending.dart    # Spending input
│   │   │       └── item_bottom_tab.dart   # Bottom tab items
│   │   │
│   │   ├── onboarding/           # App introduction
│   │   │   ├── onboarding_body.dart       # Onboarding content
│   │   │   └── onboarding_page.dart      # Onboarding screen
│   │   │
│   │   ├── signup/               # User registration
│   │   │   ├── bloc/             # Signup state management
│   │   │   │   ├── signup_bloc.dart      # Signup logic
│   │   │   │   ├── signup_event.dart     # Signup events
│   │   │   │   └── singup_state.dart     # Signup states
│   │   │   ├── gender_widget.dart        # Gender selection
│   │   │   ├── signup_form.dart          # Signup form
│   │   │   ├── signup_page.dart          # Signup screen
│   │   │   └── verify/           # Email verification
│   │   │       └── input_wallet.dart     # Wallet input
│   │   │
│   │   ├── view_spending/        # Spending details
│   │   │   ├── view_image.dart           # Image viewer
│   │   │   └── view_spending_page.dart   # Spending details
│   │   │
│   │   └── chatbot/              # AI chatbot
│   │       └── chatbot_page.dart # Chatbot screen
│   │
│   └── setting/                   # App settings
│       ├── bloc/                  # Settings state management
│       │   ├── setting_cubit.dart # Settings logic
│       │   └── setting_state.dart # Settings states
│       └── localization/          # Multi-language support
│           ├── app_localizations_delegate.dart  # Localization delegate
│           ├── app_localizations_setup.dart     # Localization setup
│           └── app_localizations.dart           # Localization logic
│
├── 📦 pubspec.yaml                # Dependencies & config
├── 📄 pubspec.lock                # Locked dependencies
├── 📖 README.md                   # Project documentation
├── 📋 PROJECT_STRUCTURE.md        # This file
├── 🧪 test/                       # Unit tests
│   └── widget_test.dart           # Widget tests
├── 🌐 web/                        # Web platform
│   ├── favicon.png                # Web favicon
│   ├── icons/                     # Web icons
│   ├── index.html                 # Web entry point
│   └── manifest.json              # Web manifest
└── 🪟 windows/                    # Windows platform
    ├── CMakeLists.txt             # Windows build config
    ├── runner/                    # Windows runner
    └── flutter/                   # Flutter Windows
```

## 🔧 Key Files Explained

### **Core Files:**
- `lib/main.dart` - App entry point, authentication flow
- `lib/controls/spending_firebase.dart` - Firebase CRUD operations
- `lib/models/` - Data models (Spending, User, Filter)
- `lib/page/main/main_page.dart` - Main navigation & bottom tabs

### **Authentication:**
- `lib/page/login/` - Login flow with BLoC pattern
- `lib/page/signup/` - Registration with email verification
- `lib/page/forgot/` - Password recovery

### **Main Features:**
- `lib/page/main/home/` - Daily spending overview
- `lib/page/main/calendar/` - Calendar view with search
- `lib/page/main/analytic/` - Charts & reports
- `lib/page/main/profile/` - User settings & profile

### **AI Integration:**
- `lib/page/chatbot/chatbot_page.dart` - Gemini AI chatbot

### **Localization:**
- `lib/setting/localization/` - Multi-language support
- `assets/lang/` - Translation files (en.json, vi.json)

### **Configuration:**
- `android/app/google-services.json` - Firebase Android config
- `ios/Runner/GoogleService-Info.plist` - Firebase iOS config
- `pubspec.yaml` - Dependencies & app metadata 