# RO-PUF em FPGA Cyclone V para Autenticação de Dispositivos Embarcados

Repositório do TCC de Especialização em Microeletrônica para Front-end Digital — UEMA.

**Discente:** Jeane Ferreira de Oliveira  
**Orientador:** Prof. Dr. Paulo Fernandes da Silva Júnior  
**Ano:** 2026–2027

## Objetivo

Implementar uma RO-PUF em FPGA Intel Cyclone V, integrada a um protocolo leve de desafio-resposta com mascaramento por XOR, permutação de bits e função hash leve, para autenticação funcional de dispositivos embarcados.

## Escopo

Faz parte do escopo: implementação em SystemVerilog, simulação funcional, síntese no Quartus Prime, programação do FPGA, integração RO-PUF + FSM + mascaramento + hash e validação funcional.

Não faz parte do escopo: caracterização física da PUF, uniformidade, BER, unicidade, correção de erros complexa, hash própria e validação com múltiplos FPGAs.

## Status

- [x] Estrutura do repositório
- [x] README
- [x] Fichamento preliminar
- [x] Arquitetura v0.1
- [x] Esqueleto RTL
- [x] Testbench inicial
- [x] Constraints preliminares
- [ ] Simulação funcional no Questa/ModelSim — **pendente**
- [ ] Síntese no Intel Quartus Prime — **pendente**
- [ ] Programação do FPGA — **pendente**
- [ ] Integração final e validação — **pendente**

> **Nota:** a simulação e a síntese ainda não foram executadas. O repositório contém o esqueleto do projeto e a documentação inicial. Os resultados serão registrados após a execução.

## Estrutura

```text
docs/          Documentação: fichamento e arquitetura
rtl/           Módulos SystemVerilog
tb/            Testbench
constraints/   Arquivo QSF preliminar para Quartus
