# 🚀 Импорт в Android Studio и быстрый старт

## Шаг 1: Открыть проект в Android Studio

1. **Скачай Android Studio** (если ещё не установлена)
   - Переходи на https://developer.android.com/studio

2. **Открой проект:**
   - File → Open
   - Выбери папку `wc2026_android_studio`
   - Дождись синхронизации Gradle

## Шаг 2: Установи Flutter (если ещё не установлен)

```bash
# В терминале Android Studio:

# 1. Скачай Flutter
# https://flutter.dev/docs/get-started/install

# 2. Добавь в PATH
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Проверь установку
flutter doctor

# Должно быть ✓ для всего
```

## Шаг 3: Установи зависимости

```bash
# В корне проекта (где находится pubspec.yaml):

flutter pub get

# Это может занять 2-5 минут
```

## Шаг 4: Сгенерируй код (важно!)

```bash
flutter pub run build_runner build

# Если ошибка, попробуй:
flutter pub run build_runner build --delete-conflicting-outputs
```

## Шаг 5: Получи API ключ

1. Переходи на https://api.anthropic.com
2. Зарегистрируйся
3. Создай новый API ключ
4. Скопируй ключ вида `sk-ant-...`

## Шаг 6: Запусти приложение

### На эмуляторе:

```bash
# Запусти эмулятор Android из Android Studio
# Или:
flutter devices  # Проверь доступные устройства

# Запусти
flutter run
```

### На реальном телефоне:

```bash
# 1. Включи Developer Mode
# Настройки → О телефоне → Build Number (7 раз)

# 2. Включи USB Debugging
# Настройки → Developer Options → USB Debugging

# 3. Подключи телефон через USB

# 4. Запусти
flutter run --release
```

## Ошибки и решения

### "Gradle sync failed"

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### "Лицензии Android SDK не приняты"

```bash
flutter doctor --android-licenses
# Нажимай y для каждой лицензии
```

### "Устройство не найдено"

```bash
flutter devices  # Проверь подключение
adb devices     # Или используй adb
```

### "Ошибка при компиляции"

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Файловая структура

```
wc2026_android_studio/
├── lib/
│   ├── main.dart              # Главный файл
│   ├── models/                # Модели данных
│   ├── providers/             # State management
│   ├── services/              # Сервисы
│   └── screens/               # Экраны UI
├── android/                   # Конфигурация Android
├── ios/                       # Конфигурация iOS
├── pubspec.yaml              # Зависимости
└── ANDROID_STUDIO_SETUP.md   # Эта инструкция
```

## Что дальше?

1. **Добавь API ключ** в приложении (Settings)
2. **Выбери команды** для анализа
3. **Запусти анализ** и смотри результаты

## Сборка APK

### Debug версия (для тестирования):

```bash
flutter build apk --debug
# Выход: build/app/outputs/flutter-apk/app-debug.apk
```

### Release версия (для публикации):

```bash
flutter build apk --release
# Выход: build/app/outputs/flutter-apk/app-release.apk
```

## Установка APK на телефон

```bash
# Способ 1: Через flutter
flutter install

# Способ 2: Через adb
adb install build/app/outputs/flutter-apk/app-debug.apk

# Способ 3: Вручную
# Скопируй APK на телефон, открой и установи
```

## Требования

- **Flutter:** 3.16+
- **Dart:** 3.0+
- **Android SDK:** 21+
- **Java:** 11+

## Помощь

Если что-то не работает:

1. Запусти `flutter doctor -v` для диагностики
2. Посмотри логи: `flutter run -v`
3. Очисти проект: `flutter clean && flutter pub get`
4. Переинсталлируй зависимости: `flutter pub run build_runner build`

---

**Готово! Приложение должно запуститься! 🎉**

Вопросы? Посмотри официальную документацию Flutter:
https://flutter.dev/docs

