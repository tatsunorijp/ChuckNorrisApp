  

# ChuckNorris App

## O que é?
Este é um aplicativo para demonstrar uma parte do meu conhecimento em desenvolvimento de aplicativos mobile para a plataforma iOS.
Consiste basicamente em consumir dados da API [ChuckNorrisAPI](https://api.chucknorris.io/)

### Como executar?
Para executar clone o repositório e instale as dependências com o cocoa pods
> _git clone https://github.com/tatsunorijp/ChuckNorrisApp_

> _pod install_

### Dependências utilizadas:

1.  [RxSwift](https://github.com/ReactiveX/RxSwift)
- Programação reativa

2.  [Swiftgen](https://github.com/SwiftGen/SwiftGen)

- Geração automática de código

- Fonts, assets e colors

3.  [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

- Geração automática de código

- Utilizado para testes

4.  [Swiftlint](https://github.com/realm/SwiftLint)

- Ferramenta para assegurar identação e algumas boas práticas de programação

5.  [IGListKit](https://github.com/Instagram/IGListKit)

- Melhoria de performace em listas (criado e utilizado pelo Instagram)

6.  [TinyConstraints](https://github.com/roberthein/TinyConstraints)

- Funções de constraints para ViewCode

7.  [Alamofire](https://github.com/Alamofire/Alamofire)

- Utilizado para criar a camade de networking
8. [Fastlane] (https://fastlane.tools/)
- Para configuração de CI/CD (em produção)

8. [Fastlane] (https://fastlane.tools/)

- Para configuração de CI/CD

  

## Arquitetura

### MVVM + RIBS

  

Criado pelo Gigante [Guilherme Souza](https://www.linkedin.com/in/grsouza/)

![MVVM+RIBs](https://i.imgur.com/mIfIWf5.png)

  

### ViewController

- Se encarrega da exibição dos dados para o usuário

- Recebe os dados já formatados da ViewModel para a exibição na View

- Recebe informações sobre quando exibir/esconder algo, quando ir para outra tela etc

- Envia os dados da view para a ViewModel tratar-las de acordo a lógica necessária

### ViewModel

- Recebe os dados do interactor e os formata para enviar a viewcontroller

- Recebe dados da ViewController para enviar ao interactor

- Recebe dados da ViewController para processar alguma lógica da própria (ex: quando habilitar um botão, quando mostrar uma label, etc).
- Nesta classe está toda a lógica cena, portanto, é a classe principal a ser testada, logo, é criado um InteractorMock (gerado automáticamente pelo sourcery) e então injetado na ViewModel para a realização dos testes unitários (com XCTest e RxTest) 

  

### Interactor

- Responsável em fazer as requisições dos dados (neste caso, ao ChuckNorrisAPI)

  

### Router

- Instancia outros builders para navegação entre telas

## CI/CD
Para a configuração de CI foi utilizado fastlane com a nova versão esrita em swift. Para ver mais detalhes da implementação acesse a pasta fastlane/swift/FastlaneSwiftRunner e abra o arquivo .xcodeproj, lembrando que esta é apenas uma simulação do CI.
A parte do CD infelizmente não foi configurado devido a que é necessário uma conta de desenvolvedor da apple (100$ D: )

Caso queria testar, intale o fastlane com o seguinte comando:

> brew install fastlane

e na pasta raiz do projeto execute o comando

> fastlane runAllCi
