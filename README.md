# Book Explorer App

A Flutter application demonstrates **clean architecture**, **Bloc state management**, and **REST API** .

## API Used

**Endpoint**

```
https://fakerapi.it/api/v2/books?_quantity=10

```

---

## Features

### Book List Screen

- Fetches books from API
- Displays book cover, title, and author
- Pull-to-refresh support
- Favourite state
- Loading, error, and empty states

### Book Detail Screen

- Displays full book information
- Shows favorite state

### Local State Synchronization

- Favorite state updates in all two screens
- State is preserved in navigation

---

## Architecture

The project follows **Clean Architecture** with separation of concerns.

```
lib/
├── data/
│ ├── models/
│ ├── repositories/
│ └── data_sources/
├── presentation/
│ ├── bloc/
│ ├── screens/
│ └── widgets/
└── main.dart
```

---

## State Management (BLoC)

The assignment explicitly requires **a minimum of two BLoCs**:

- `BookListBloc`
- `BookDetailBloc`

  **favorite toggling is handled by `BookListBloc`** to maintain a **single source of truth**, the `BookDetailBloc` is **not unused**.

---

### BookListBloc

**Responsibilities**

- Fetch books from API
- Hold the list of books
- Maintain favorite state
- Synchronize state between list and detail screens
- Prevent duplicate API calls

**Events**

- `FetchBooks`
- `UpdateBookFavorite`

**States**

- `BookListLoading`
- `BookListLoaded`
- `BookListError`

---

### BookDetailBloc

**Responsibilities**

- React to UI interactions on detail screen
- Rebuild UI efficiently without depending directly on list state

The `BookDetailBloc` **does not contains the favorite state**. but:

- It receives the selected `Book` from `BookListBloc`
- It listens and rebuilds based on updates
- All mutations are send back to `BookListBloc`

This avoids:

- State duplication
- Inconsistent favorite status
- One bloc is maintinging the states about one book

this allwos to update the another state without affecting book deatils

---

## BLoC Flow

### Fetch Books

```
UI → FetchBooks → BookListBloc
   → BookListLoading
   → API Call
   → BookListLoaded / BookListError
```

### Toggle Favorite (From Detail Screen)

```
Detail UI → UpdateBookFavorite → BookListBloc
          → BookListLoaded (updated list)
          → UI rebuilds (both screens)
```

---

## Edge Cases

API failure Error - UI with retry button
Empty book list - Meaningful empty state  
 Duplicate API calls - Prevented in BLoC  
 Null / missing fields - Safe JSON parsing  
 Image load failure - Placeholder icon

---

## 🧪 Trade-offs & Improvements

### Trade-offs

- no state preserving after app restarts
- Minimal UI but concentrated on logic side

### Possible Improvements

- Local caching using Hive / SQLite

- Unit tests for BLoCs and repositories

- Pagination

- Offline support

### Flutter & Dart Environment

This project is built using latest stable Flutter and Dart versions. Some syntax and APIs used may cause errors on older Flutter SDKs.

### Flutter Version Used

Flutter 3.38.5 • channel stable
Framework • revision f6ff1529fd
Engine • revision 1527ae0ec5
Tools • Dart 3.10.4 • DevTools 2.51.1

### Important Note

If you try to run this project on an older Flutter/Dart version, you may encounter syntax or analyzer errors. Please ensure your SDK is updated to at least the versions mentioned above.

## How to Run

```bash
flutter pub get
flutter run
```

---

## Author

**Rahul P**
Flutter Developer

---
