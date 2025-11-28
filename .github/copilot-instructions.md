## nfctools — instruções rápidas para agentes de codificação

Objetivo: dar a um agente (Copilot/AI) o contexto mínimo e exemplos práticos para atuar produtivamente neste repositório Flutter.

- Linguagem/stack: Flutter (Dart). Projeto multiplataforma (android, linux, macos) com código nativo em cada pasta de plataforma.

Principais pontos — arquitetura e locais chave
- UI e lógica Flutter: `lib/`
  - Telas: `lib/screens/` (ex.: `lib/screens/main_window.dart` é ponto de entrada UI usado durante desenvolvimento).
  - Widgets reaproveitáveis: `lib/widgets/` (ex.: `lib/widgets/tag_scan_dialog.dart`).
  - Modelos/dados: `lib/models/`.
  - Assets locais: `lib/assets/` (imagens, fontes) e referenciados via `pubspec.yaml`.
- Integrações nativas e plugins
  - Plugin NFC / código nativo: olhar `nfc_manager/`, `native_assets/` e diretórios de plataforma (`android/`, `linux/`, `macos/`).
  - Modificações nativas (C++/C#/Swift/Kotlin) residem nas subpastas de cada plataforma e podem exigir builds nativos.

Fluxos e comandos úteis (rápido)
- Rodar em debug (desktop Linux):
  - `flutter run -d linux`
- Rodar no Android (emulador/dispositivo):
  - `flutter run -d android`
  - Para gerar APK: `flutter build apk`
- Testes unitários/widget:
  - `flutter test` (executa arquivos em `test/` — há um `test/widget_test.dart`).

Padrões de código e convenções do projeto
- Organização: separar telas (`screens`), widgets (`widgets`) e modelos (`models`). Ao adicionar uma nova tela, coloque-a em `lib/screens/`.
- Widgets visuais simples (Dialogs, BottomSheet) devem usar `mainAxisSize: MainAxisSize.min` quando for necessária altura compacta (ex.: diálogos em `lib/widgets`).
- Localização e Material: o app espera delegates de localização em `MaterialApp` se for usado `showDialog`/widgets Material — veja seção "Problemas comuns".

Pontos de integração e dependências descobertas
- Dependências gerenciadas em `pubspec.yaml`. Plugins nativos e assets também têm configurações correspondentes nas pastas `android/`, `linux/`, `macos/`.
- Arquivos nativos podem exigir execução do Gradle/CMake. Para builds Android use o wrapper presente (`android/gradlew`).

Exemplos práticos (padrões recorrentes)
- Adicionar delegates de localização para evitar erro "No MaterialLocalizations found":
  - Em `MaterialApp` adicionar `localizationsDelegates` e `supportedLocales` (pacote `flutter_localizations`).
  - Arquivo de referência: `lib/screens/main_window.dart` onde diálogos são usados diretamente.
- Ao abrir diálogos com `showDialog`, passar `context` proveniente de `MaterialApp` e envolver conteúdo em `Padding`/`Column(mainAxisSize: MainAxisSize.min)` para evitar overflow.

Problemas comuns e checagens rápidas
- Erro frequente: "No MaterialLocalizations found" — solução: habilitar `flutter_localizations` e os delegates em `MaterialApp`.
- Se o plugin NFC falhar no desktop/mobile, verifique se as permissões e o código nativo foram configurados nas pastas de plataforma e se o plugin está listado em `pubspec.yaml`.

Onde procurar mais contexto
- Código: `lib/` (principal), `android/`, `linux/`, `macos/`.
- Configuração de build Android: `android/app/build.gradle.kts` e `android/gradle.properties`.
- Manifestos de plataforma e assets: `pubspec.yaml`.

Se precisar de algo mais
- Peça exemplos de telas específicas, padrões de teste (ex.: mocks para plugins nativos) ou que eu gere snippets/PRs com correções rápidas (p.ex. adicionar delegates de localização em `lib/screens/main_window.dart`).

-- fim
