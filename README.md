# desafio-ios
Desafio de iOS para candidatos

# Criar um aplicativo de consulta a API de Filmes #

Criar um aplicativo para consultar a API de Filmes e trazer os filmes enviados pelo endpoint. Seguem abaixo telas como guia:

<img src="https://i.imgur.com/wJulkN7.png" height="300" />  <img src="https://i.imgur.com/KtU2Qve.png" height="300" />

### **O aplicativo deve contemplar** ###

- __Uma lista de filmes__. Exemplo de chamada na API: `https://desafio-mobile-pitang.herokuapp.com/movies/list?page=0&size=3`.
    * Paginação na tela de lista, com scroll infinito (incrementando o parâmetro `page`).
    * Cada filme deve exibir Nome do filme e Foto do filme.
    * Ao clicar em um item da lista, deve levar ao detalhe do filme.
- __Detalhes de um filme__. Exemplo de chamada na API: `https://desafio-mobile-pitang.herokuapp.com/movies/detail/59e8ec97f36d280364369ca1`.
    * O item de detalhe deve exibir Nome, Foto e Descrição do filme.

### **Essencial** ##
* IDE Utilizada deve ser o Xcode na versão mais atual do Swift
* O gerenciador de dependêcias deve ser o CocoaPods
* Deve ser usada uma biblioteca para Mapeamento/Parser de JSON (ObjectMapper / SwiftJSON)
* Devem ser usados os guidelines UX e UI do iOS
* Uso de Auto Layout Guide

### **Desejavel** ###

* Utilização de Storyboards
* Arquitetura MVVM
* Cache de imagens e da API

### **Sugestões** ###

Nesta seção sugerimos algumas bibliotecas para o uso, mas fique à vontade para escolher outras que não estiverem na lista.

* AlamofireImage
* Firebase
* Alamofire
* R.swift
* Crashlytics

### **OBS** ###

A foto das telas de mockup são só um guia, fique a vontade para usar o padrão de usabilidade da sua escolha.

### **Etapas para submissão** ###

O canditado ao finalizar a implementação deverá enviar um pull request para o repositório em questão.

Segue o passo-a-passo:

1. Fazer fork do respositório
2. Implementar seu projeto no fork realizado.
3. Comitar e subir todas as alteraçes para o fork criado por você.
4. Enviar um pull request pelo Github.

O fork deverá ser público para inspeção do código.

### **Observações** ###

Não fazer push para este repositório.
