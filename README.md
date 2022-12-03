<h1 align="center" style="font-size: 16px;"> :man_technologist:   Projeto Gestão Financeira:moneybag: - Grupo 9 <h1>

<p align="center"><img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge"/></p>

### :new: Um novo projeto Dart/Flutter.
### 📁 Acesso ao projeto<br>
> **Código fonte do projeto diponível no [GitHub](https://github.com/proz-tecnologia/PIT02GP09)**<br>
> **Prototipação do designe no [Figma](https://www.figma.com/file/9KqM20u8dvdgHR7wi8nI4O/Projeto-Proz?node-id=20%3A408**<br>)**  

### 🛠️ Abrir e rodar o projeto<br>
> - **Baixar o projeto do [GitHub](https://github.com/proz-tecnologia/PIT02GP09);**<br>
> - **Gerar um APK de instalação fazendo o seguinte processo: no diretório(raiz) do projeto abra o terminal e execute o seguinte comando "flutter build apk --nome-apk". Obs.: os SDKs de Dart e Flutter tem que estarem previamente instalados e configurados na máquina que realizar a build";**<br>  
> - **Mova o APK para um dispositivo Android e execute-o.**<br>

## :star: Começando
### :trophy: Objetivo do projeto
> _Este projeto visa criar uma aplicação de gestão financeira pessoal, fazendo controle de receita e despesas assim como das movimentações dos cartões de crédito, geram relatórios sobre ambos os recursos e de forma geral. Está sendo usado as tecnologias Dart/Flutter para dispositivos Android sem versão miníma definida._<br>
### :hammer: Funcionalidades do projeto<br> 
> `Flow Login`: é composto pelas páginas splash screen, login, sign up e reset password<br> 
> `Home Page`: página inicial atrelada a conta do usuário com informações finceiras de todos os grupos<br> 
> `Revenue Page`: página com a entrada de todas as receitas e suas funções<br> 
> `Expenses Page`: página com todas as depesas e suas funções<br>
> `Credit Card Page`: página com movintação dos cartões de crédit e suas funções<br>
### :hammer: Tecnologias e processos utiliazados<br> 
> `Padrão Arquitetural`: **Modular** - Rotas modularizadas - Injeção de Dependência Modularizada - Estrutura dividida por escopo - <br>
> > **Resumindo**: Modular é uma solução para modularizar o sistema de injeção de rotas e dependências, fazendo com que cada escopo tenha suas próprias rotas e injeções independente de qualquer outro fator da estrutura. Criamos objetos para agrupar as Rotas e Injeções e os chamamos de Módulos <br>
> 
> `Model-View(Page)-Constroller`: é usando **MVC** em escopo, onde cada recurso tem seu próprio MVC e essa abordagem ajuda a reduzir muitos problemas de escalabilidade e manutenção <br>
>
> `Bloc`: O objetivo deste pacote é facilitar a implementação do BLoCDesign Pattern (**Componente de Lógica de Negócios**)<br>
> >**Padrão de Projeto**: ajuda a separar a apresentação da lógica de negócios . Seguir o padrão BLoC facilita a testabilidade e a reutilização. Este pacote abstrai os aspectos reativos do padrão, permitindo que os desenvolvedores se concentrem em escrever a lógica de negócios.<br> O **Bloc** é uma classe mais avançada que depende **events** de acionar statealterações em vez de funções, receba **events** e converta o recebido eventsem enviado **states**<br>
> 
> `flutter_bloc`: Widgets que facilitam a integração de blocos e côvados no Flutter . Construído para funcionar com package:bloc <br>
> > `BlocBuilder`: É um widget Flutter que requer uma bloce uma builderfunção. **BlocBuilder** lida com a construção do widget em resposta a novos estados. BlocBuilder é muito semelhante, StreamBuildermas tem uma API mais simples para reduzir a quantidade de código clichê necessário. A builderfunção será potencialmente chamada várias vezes e deve ser uma função pura que retorna um widget em resposta ao estado.
	
### :ticket: Licença, versões e status de softwares<br>	
_Licença: Instituto de Tecnologia de Massachusetts (MIT);_<br>
_Versão do SDK Flutter/Dart:_<br>
> _Flutter 3.3.7 • channel stable • https://github.com/flutter/flutter.git_ <br>
> _Framework • revision e99c9c7cd9 (4 weeks ago) • 2022-11-01 16:59:00 -0700_<br>
> _Engine • revision 857bd6b74c_<br>
> _Tools • Dart 2.18.2 • DevTools 2.15.0_<br>
> _Dependencies_<br>
> > _flutter:_<br>
> > >_sdk: flutter_<br>
> >
> >_brasil_fields: ^1.6.0_<br>
> >_shared_preferences: ^2.0.15_<br>
> >_flutter_modular: ^5.0.3_<br>
> >_flutter_bloc: ^8.1.1_<br>
> _Data da última versão do projeto: dezembro._<br>
	
## :octocat:Desenvolvedores

| [<img src="https://avatars.githubusercontent.com/u/70405742?v=4" width=115><br><sub>Hugo Daudt</sub>](https://github.com/HugoDaudt) |  [<img src="https://avatars.githubusercontent.com/u/112892707?v=4" width=115><br><sub>Amanda Mendanha</sub>](https://github.com/Amanda-Mendanha) |  [<img src="https://avatars.githubusercontent.com/u/113555317?v=4" width=115><br><sub>Tamires de Carvalho</sub>](https://github.com/TamiresDCarvalho) |  [<img src="https://avatars.githubusercontent.com/u/67833327?v=4" width=115><br><sub>Rodrigo Oliveira</sub>](https://github.com/rexoliveira) |
| :---: | :---: | :---: | :---: 
