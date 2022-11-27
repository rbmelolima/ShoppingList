## 📃 Sobre
##### Introdução
O cenário econômico do Brasil sempre teve a maior parte da população com pouco poder aquisitivo, e, com a pandemia e conflitos políticos nacionais e mundiais crescentes, essa realidade se tornou ainda mais crítica. Os aumentos crescentes e exorbitantes dos bens de consumo básicos como arroz, carnes, verduras e legumes impôs uma dura realidade aos brasileiros.

A lista de compras inteligente é uma solução mobile, com interface simplificada, que permite a criação de uma lista de compras com análise e comparação dos preços finais entre os maiores supermercados, buscando os mais baratos e próximos, e podendo ser compartilhada entre os membros da família.

O aplicativo vem como auxílio para as famílias afetadas por esse cenário ao proporcionar de forma simples e eficaz a análise de preços e comparação entre supermercados para fornecer uma maior economia nas compras. O usuário poderá criar sua lista de compra, fornecendo nome e quantidade de cada um dos itens que deseja comprar, e o sistema trará no mínimo três estabelecimentos ordenados pelo menor valor total da compra, trazendo também todos os valores unitários dos produtos, possibilitando uma compra mais econômica e assertiva.

##### Sobre a API
A Lista de Compras Inteligente possui como back-end uma API desenvolvida em C# sobre a plataforma .NET 6. A API faz uso de um método de extração de dados conhecido como web scraping (varredura na web). Após receber uma requisição contendo os nomes dos produtos a serem buscados, um browser headless é emulado pelo sistema e abre uma guia para cada produto, fazendo a busca em paralelo para maior performance. Ao realizar a busca com os parâmetros fornecidos, a API é responsável por extrair três informações de todos os anúncios encontrados: nome do fornecedor, nome do produto e seu valor. Por fim são eliminadas quaisquer redundâncias nos dados e os produtos retornados de forma agrupada por fornecedor, contendo também o valor total da lista de compras.

Para facilitar seu desenvolvimento e publicação utilizamos conteinerização via Docker, o que nos deu grande vantagem ao levar o sistema para a AWS.

Disponível [aqui](https://github.com/igortelheiro/Fatec-ListaDeComprasInteligente)!

## 🔨 Instalação
**Requerimentos mínimos**:
- Flutter instalado e configurado na sua máquina
- Emulador Android ou iOS, ou dispositivo físico disponível

```bash
# Clone o projeto
git clone https://github.com/rbmelolima/ShoppingList.git

# Navegue para a pasta
cd ShoppingList

# Instale todas as dependências
flutter pub get

# Rode o projeto
flutter run lib/main/main.dart
```


## 🎯 Features
- [x] Gerenciamento de listas
- [x] Gerenciamento de produtos 
- [x] Compartilhamento de listas
- [x] Busca de menor preço
- [ ]  Ordenação de listas
- [ ]  Ordenação de produtos
- [ ]  Exportar lista de compras em PDF
- [ ]  Lixeira (recuperar listas excluídas)

## 🔗 Referências
- [Design by @rbmelolima](https://www.figma.com/file/3BCcMUSxDhn8OkWFrqoZZ3/Lista-de-compras-inteligente?node-id=2%3A9);
- [Shopping, Lottie](https://lottiefiles.com/83548-online-shopping-black-friday)
- [API Lista de compras inteligente](https://github.com/igortelheiro/Fatec-ListaDeComprasInteligente)

