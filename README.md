# Giropops Senhas NGINX - Um projeto de estudos de Docker

Este é um projeto de fim de semana para fins de estudo.
A ideia é utilizar a aplicação [giropops-senhas](https://github.com/badtuxx/giropops-senhas) (créditos ao [Jeferson Fernando](https://github.com/badtuxx)), replicando-a em três (ou N) containers e utilizando um container NGINX como proxy reverso, fazendo uma terminação TLS/SSL. O projeto também contem um Redis para armazenar os dados enquanto a aplicação está rodando.

![Diagrama](drawings/giropops-senhas-nginx.drawio.png)

## Objetivos

- Praticar a utilização de multi-stage build e imagens distroless
- Entender o funcionamento de um serviço com múltiplas réplicas provisionado com Docker Compose
- Entender o funcionamento de secrets com Docker Compose
- Revisar o uso de nginx como proxy reverso e terminação TLS/SSL

## Estrutura do repositório

```
.
|——— giropops-senhas/      -> Código fonte do giropops-senhas e um Dockerfile de imagem distroless e nonroot
|——— nginx/
|    |——— cmd.sh           -> Pequeno comando shell para iniciar o nginx. Substitui variáveis de ambiente no arquivo de configuração nginx.conf já que o nginx não possui suporte nativo para variáveis de ambiente
|    |——— Dockerfile       -> Dockerfile. Utiliza o cmd.sh como CMD
|    |——— nginx.conf       -> Arquivo de configuração do nginx
|——— docker-compose.yaml   -> Realiza a subida dos containers do giropops-senhas, nginx e redis
```

## Requisitos e ambiente de desenvolvimento

Este projeto foi desenvolvido e testado com:

- Ubuntu 24.04.4 LTS
- Docker Engine 29.2.1
- Docker Compose v5.0.2

## Como executar

```
export SERVER_CERT_PATH=<path do seu certificado TLS>
export SERVER_KEY_PATH=<path da chave privada TLS>
docker compose up -d

```

### O que aprendi e dificuldades

- É necessário tomar cuidado com a compatibilidade das versões python entre a imagem builder e imagem de execução em multi-stage builds.
- Dependendo do repositório, é necessário pinar o digest da imagem para garantir que a versão da stack interna não seja alterada (percebi isso no gcr.io/distroless) 
- Services do Docker Compose oferecem um Load Balancer ([DNS Round Robin](https://docs.docker.com/reference/compose-file/deploy/#attributes))
- Caso o processo de um container seja executado por um usuário não root, é preciso se atentar com as permissões de acesso aos arquivos que o processo utiliza