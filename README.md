# Flutter Micro-Frontend Codebase

Este projeto tem a finalidade de ajudar e agilizar novos projetos Flutter, voltados para micro-frontends, facilitando a abstração de vários componentes e funcionalidades geralmente sempre utilizadas em projetos de pequeno, médio e grande porte.

## Inicializando o projeto

Para inicializar o projeto, foi definido uma série de scripts que visam agilizar alguns comandos utilizados. Para inicializar o projeto, assim que clonado, deve-se criar os seguintes arquivos:

```
base_app/
    .env/
        .env
        .env.dev
        .env.hml
    .firebase/
        dev/
            google-services.json
            GoogleService-Info.plist
        hml/
            google-services.json
            GoogleService-Info.plist
        prod/
            google-services.json
            GoogleService-Info.plist
```

Após a criação dos arquivos de ambiente locais, deve-se executar o seguinte script na pasta raíz do repositório:

`./scripts.sh --get`

Assim irá executar o comando para obter as dependências de todos os packages e modules existentes no projeto.

Seguindo esses passos, está apto para executar o projeto em qualquer ambiente: `dev`, `hml` ou `prod`.

Qualquer dúvida ou contribuição, entre em contato através das minhas redes:

- [LinkedIn](https://www.linkedin.com/in/leonardo-bido/)

- [Instagram](https://www.instagram.com/leobidoous/)
