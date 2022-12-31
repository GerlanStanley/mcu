![Dart Version](https://img.shields.io/static/v1?label=dart&message=2.18.6&color=00579d)
![Flutter Version](https://img.shields.io/static/v1?label=flutter&message=3.3.10&color=42a5f5)
![Null Safety](https://img.shields.io/static/v1?label=null-safety&message=done&color=success)

# Finances App
Esse é um app desenvolvido em flutter/dart que lista filmes do MCU

## Principais bibliotecas/tecnologias utilizadas
- Gerenciamento de estado: [Bloc](https://pub.dev/packages/bloc), [Flutter_bloc](https://pub.dev/packages/flutter_bloc)
- Injeção de dependências: [GetIt](https://pub.dev/packages/get_it)
- Requisições http: [Dio](https://pub.dev/packages/dio)
- Testes: [Mocktail](https://pub.dev/packages/mocktail), [bloc_test](https://pub.dev/packages/bloc_test)

## Arquitetura
- Nesse projeto foi utilizada uma arquitetura limpa com Domain, Data e Presenter

## API
Foi utilizado um mock da api da marvel: https://mocki.io/v1/246679d2-5063-466f-84ef-6157bf334da2

## Testes
Foram implementados testes de unidades, widgets e integração

## Build/Tests
Passo 1: [Instale o Flutter](https://docs.flutter.dev/get-started/install)
(Versão utilizada no desenvolvimento: 3.3.10)

Passo 2: Baixe ou clone este repositório usando o link abaixo:
```
https://github.com/GerlanStanley/mcu.git
```

Passo 3: Vá para a raiz do projeto e execute o seguinte comando no console para obter as dependências necessárias:
```
flutter pub get
```

Passo 4: Para executar o projeto realize o comando
```
flutter run
```

Passo 5: Para executar os testes realize o comando
```
flutter test
```

## Screenshots
<p float="left">
    <img src="./screenshots/1.png" width="400" />
    <img src="./screenshots/2.png" width="400" /> 
</p>