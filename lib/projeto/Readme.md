# Saborê — Aplicativo de Receitas

## Descrição

Este aplicativo foi desenvolvido em Flutter como uma atividade da faculdade. O objetivo é praticar a construção de telas, navegação, consumo de API e apresentação de dados.

O aplicativo utiliza a API pública DummyJSON Recipes para buscar receitas. É possível pesquisar pelo nome, consultar ingredientes e modo de preparo e selecionar receitas favoritas.

## Funcionalidades

- Carregamento de até 30 receitas ao abrir o aplicativo.
- Listagem com nome e imagem das receitas.
- Ícone alternativo quando uma imagem não estiver disponível.
- Pesquisa de receitas pelo nome utilizando a API.
- Validação para impedir pesquisas vazias.
- Botão para limpar a pesquisa e retornar à listagem.
- Tela de detalhes com ingredientes, instruções e informações disponíveis.
- Adição e remoção de favoritos, sem duplicar receitas.
- Indicador de carregamento durante as requisições.
- Mensagem de erro com opção de tentar novamente.
- Navegação entre as telas, preservando a consulta ao retornar.

Os favoritos ficam armazenados somente na memória durante a sessão. Ao encerrar o aplicativo, eles não são mantidos.

## Telas

- **Perfil:** página principal com pesquisa e listagem.
- **DetalhesReceita:** apresenta as informações da receita selecionada.
- **Favoritos:** mostra as receitas escolhidas pelo usuário.

## Dependências

Dependências utilizadas no projeto:

- `flutter`: construção da interface.
- `http: ^1.6.0`: chamadas à API.
- `cupertino_icons: ^1.0.8`: ícones disponíveis no projeto.

Dependências de desenvolvimento:

- `flutter_test`: testes do aplicativo.
- `flutter_lints: ^6.0.0`: análise e recomendações para o código.

## SDK

O projeto utiliza Flutter e Dart.

A configuração do Dart informada no `pubspec.yaml` é:

```yaml
environment:
  sdk: ^3.13.5
```

Para consultar as versões instaladas do Flutter e do Dart, execute:

```bash
flutter --version
```

## Instruções de execução

1. Instale o Flutter SDK e configure um editor, como Android Studio ou VS Code.
2. Abra a pasta do projeto.
3. No terminal, dentro da pasta que contém o `pubspec.yaml`, instale as dependências:

```bash
flutter pub get
```

4. Inicie um emulador ou conecte um celular configurado para desenvolvimento.
5. Execute o aplicativo:

```bash
flutter run
```

É necessário acesso à internet para carregar as receitas e suas imagens.

No Android, o arquivo `android/app/src/main/AndroidManifest.xml` deve conter esta permissão dentro de `<manifest>`, antes de `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## API utilizada

Os dados são obtidos da API DummyJSON Recipes.

Endpoints utilizados:

- Listagem: `https://dummyjson.com/recipes?limit=30`
- Pesquisa: `https://dummyjson.com/recipes/search?q=nome&limit=30`

A tela de detalhes aproveita o objeto completo recebido na listagem ou na pesquisa, sem realizar uma nova requisição para a mesma receita.