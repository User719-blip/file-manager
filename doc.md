lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── services/      # e.g., permission handler, file operations
│   └── utils/
│
├── shared/
│   ├── widgets/       # Common UI (cards, buttons, loaders)
│   └── styles/
│
├── features/
│   ├── search/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── pages/search_page.dart
│   │       ├── widgets/search_bar.dart
│   │       └── cubit/search_cubit.dart
│
│   ├── categories/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── pages/categories_page.dart
│   │       ├── widgets/category_tile.dart
│   │       └── bloc/category_bloc.dart
│
│   ├── storage_options/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── pages/storage_page.dart
│   │       ├── widgets/storage_card.dart
│   │       └── cubit/storage_cubit.dart
│
│   ├── tools/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── pages/tools_page.dart
│   │       ├── widgets/tool_tile.dart
│   │       └── bloc/tools_bloc.dart
│
│   └── home/
│       ├── presentation/
│       │   ├── pages/home_page.dart
│       │   └── widgets/home_sections.dart
│
└── main.dart
