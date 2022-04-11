# presença

Aplicativo que lhe ajuda a gerir as listas de presença de suas disciplinas.

# Para desenvolvedores:

_Primeiramente instale o [flutter][flutter-install] no seu SO._

Realize um fork do repositório no github, abra seu terminal e execute:

```bash
# Clone the repo into your computer
git clone --depth 1 https://github.com/<SEU_USUARIO>/presenca.git
```

- Para executar o aplicativo:
  ```bash
  # Get to where you cloned the repo
  cd /path/to/presenca

  # Get dependencies
  flutter pub get

  # Run code generation
  flutter pub run build_runner build --delete-conflicting-outputs

  # Run the app
  flutter run
  ```

[flutter-install]: https://docs.flutter.dev/get-started/install
