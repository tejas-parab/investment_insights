# FinView Lite – Investment Insights Dashboard (Flutter)

A beautiful, responsive Flutter web/mobile dashboard that visualizes stock portfolio performance using local JSON data — no backend required.

## Features Implemented

- Local `assets/portfolio.json` with multi-user support
- Authenticated login (only valid users from JSON)
- Header with user name, total value, and gain/loss
- Holdings list with **computed gain per stock** (₹ and %)
- Interactive **Pie Chart** (`fl_chart`) showing asset allocation
- Toggle between **₹ amount** and **% return**
- Sort holdings by **Name / Value / Gain**
- Graceful **empty state** ("No investments yet")
- Full **error handling** (invalid user, empty data, JSON errors)

## Bonus Features

- **Dark mode toggle** (persisted via SharedPreferences)
- **Mock login with state persistence** (auto-login on restart)
- **Manual refresh** with **real price updates** (±5% random change)

## Tech Stack

**Client:** Flutter 3.35.7

**Server:** No Backend

## Run Locally

```bash
# 1. Clone repo
git clone https://github.com/tejas-parab/investment_insights.git
cd investment_insights

# 2. Get dependencies
flutter pub get

# 3. Run on Chrome (Recommended for demo)
flutter run -d chrome

# Or run on mobile
flutter run


## Valid Users (for demo)
Aarav Patel        → Full portfolio (₹5.17L)
Priya Sharma       → Loss-making (₹95K)
Rohan Mehta        → Empty portfolio (zero investment)
Sneha Gupta        → High-value (₹12L)

## Project Structure
lib/
├── main.dart
├── models/portfolio_model.dart
├── services/data_service.dart
├── screens/login_screen.dart
├── screens/dashboard_screen.dart
├── widgets/
│   ├── header_widget.dart
│   ├── holdings_card.dart
│   ├── allocation_chart.dart
│   └── ...
assets/portfolio.json
```

## Screenshots

![App Screenshot](/assets/screenshot1.jpg?raw=true "Optional Title")
![App Screenshot](/assets/screenshot2.jpg?raw=true "Optional Title")

## Video

https://github.com/tejas-parab/investment_insights/blob/5ab1f80b4c57509654d919821cff349006806acb/assets/recording1.mp4
