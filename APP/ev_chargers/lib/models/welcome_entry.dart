class WelcomeEntry {
  final String emoji;
  final String title;
  final List<String> body;

  const WelcomeEntry(this.emoji, this.title, this.body);

  static Map<int, WelcomeEntry> getAllWelcomeEnteries() {
    return {
      0: const WelcomeEntry("👋", "Hi, we're ev4all",
          ["We make electric car charging", " easy, affordable and reliable."]),
      1: const WelcomeEntry("🤝", "We've got you covered", [
        "Wherever you are we have a charger for you. Also you can choose to make payments in advance to get your electricity even cheaper.",
        " We know pretty damn cool!"
      ]),
      2: const WelcomeEntry("👌", "Not just another ev app", [
        "We're building the most reliable charging app on the market! Working with drivers and companies alike to bring you the",
        " most accurate data and features you actually need."
      ])
    };
  }

  static WelcomeEntry getWelcomeData(int index) {
    var result = getAllWelcomeEnteries()[index];
    if (result != null) {
      return result;
    } else {
      return const WelcomeEntry('', '', []);
    }
  }
}
