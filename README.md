# Security and Auditing - Blockchain Public
Avaliação complementar da disciplina Security and Auditing - Blockchain Public no curso MBA Blockchain - FIAP

## Contexto: projeto Widig

- Widig é um projeto de tokenização de propriedades. 
- Para uma pessoa investir no projeto, ela deve fazer um depósito em Ether utilizando a função deposit.
- Quando uma pessoa fizer um depósito em Ether utilizando a função deposit, o valor depositado será dividido proporcionalmente pelas pessoas que já são donas da propriedade, ou seja, que já fizeram depósitos antes. 
- Quando uma nova pessoa investir no projeto, ou seja, fizer depósito, a pessoa anterior começa a receber a sua parte também.
- Existe um limite de participantes no empreendimento, que deve ser respeitado.

## Código fonte do smart contract
[Widig-exam.sol](Widig-exam.sol)

## Descrição
A avaliação é composta de 2 partes.

## Exercício 1 - Identificação de vulnerabilidades e problemas de lógica em Smart Contracts

O smart contract do projeto Widig tem mais de 10 problemas / vulnerabilidades.

> Analise apenas o smart contract Widig. O SafeMath não será considerado.

### Exercício 1 - parte A

Encontre pelo menos 5 problemas de lógica. Exemplos: falta de require, endereços inválidos, número máximo / mínimo de participantes

Para cada item, identifique a linha e qual o problema encontrado.

### Exercício 1 - parte B

Encontre pelo menos 5 vulnerabilidades, baseando-se no [SWC Registry - Smart Contract Weakness Classification and Test Cases](https://swcregistry.io/).

Para cada item, identifique a linha e qual a vulnerabilidade encontrada.

> Cada item encontrado vale 0,5 pontos.

## Exercício 2 - Relatório de auditoria

Escreva um relatório de auditoria do smart contract Widig, com as seguintes seções:

1. Resumo - Abstract (0,5 ponto)
2. Aviso legal – Disclaimer (0,5 ponto)
3. Recomendações gerais (0,5 ponto)
4. Metodologia de auditoria (0,5 ponto)
5. Vulnerabilidades (3,0 pontos)
  - 5.1. Itens críticos
  - 5.2. Itens de severidade média
  - 5.3. Itens de baixa severidade 

As vulnerabilidades devem ser reportadas utilizando:
-  [SWC Registry - Smart Contract Weakness Classification and Test Cases](https://swcregistry.io/)
-  [Nist - National Vulnerability Database](https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=Ethereum&search_type=all)

### Orientações
itens 1 a 4: no site da [SmartDec](https://blog.smartdec.net/smart-contracts-security-audits/home), existem diversas auditorias com estes itens, que podem ser utilizadas como exemplos. Na aula 4 foi apresentada a [auditoria da POA](https://github.com/smartdec/audits/blob/master/POA%20Network%20-%20TokenBridge.pdf). Os links também estão no PDF da aula 4, página 51. 

item 5: as classificações de vulnerabilidades foram apresentadas na aula 1 e constam no PDF da aula 1, páginas 9-10.
As vulnerabilidades em si foram identificadas no exercício 1, ou seja, no item 5 do exercício 2 deve-se apenas classificar o que já foi encontrado no exercício 1, com base nas fontes já informadas.

> Não é necessário publicar o smart contract em nenhuma plataforma para fazer este trabalho.

## Entrega
PDF na plataforma da Fiap

### Data final
Verificar na plataforma da Fiap

### O que entregar

Um documento em formato PDF com:

- nomes dos integrantes do grupo
- execício 1: lista do que foi encontrado, onde para cada item deve apresentar a linha do smart contract e o problema.
- execício 2: relatório de auditoria com as seções solicitadas. 

> O exercício 1 não deve ser entregue "dentro" do exercício 2, mas o resultado do exercício 1 poderá ser utilizado no exercício 2.

Fazer upload do PDF na plataforma da Fiap
