# Arquitetura v0.1 — RO-PUF + protocolo leve

## 1. Objetivo

Implementar uma RO-PUF em FPGA Intel Cyclone V, integrada a uma FSM de protocolo leve de desafio-resposta, com mascaramento por XOR/permutação e hash leve, para autenticação funcional de dispositivo embarcado.

## 2. Parâmetros iniciais

| Parâmetro | Valor inicial | Observação |
|---|---:|---|
| N_RO | 32 | 16 pares |
| COUNT_W | 16 bits | Contador de oscilação |
| RESP_W | 16 bits | Resposta da PUF |
| NONCE_W | 32 bits | Desafio |
| HASH_W | 64 bits no esqueleto | Na versão final, substituir por SPONGENT-88/128 |
| WINDOW_CYCLES | 1024 | Janela de contagem inicial |

## 3. Blocos

- `ring_oscillator`: oscilador em anel com enable.
- `ro_puf`: banco de 32 ROs, contadores, amostragem e comparação de pares.
- `auth_fsm`: FSM de autenticação, controle de janela, mascaramento e hash.
- `light_hash`: placeholder de hash leve; não é criptográfico.
- `top`: integração.

## 4. FSM proposta

Estados:

1. `IDLE`: espera `start`; verifica nonce repetido.
2. `RO_ON`: habilita ROs por `WINDOW_CYCLES`.
3. `SAMPLE`: desabilita ROs e amostra contadores.
4. `MASK`: calcula `M = P(R XOR nonce_low)`.
5. `HASH`: calcula `H = Hash(M || nonce || constante)`.
6. `DONE`: disponibiliza `response_hash` e `done`.
7. `ERR`: nonce repetido ou erro de fluxo.

## 5. Protocolo funcional

1. Verificador envia nonce novo `N`.
2. Dispositivo rejeita `N` se for igual ao último nonce aceito.
3. Dispositivo habilita ROs, conta oscilações, compara pares e obtém `R`.
4. Dispositivo calcula `M = P(R XOR N_low)`.
5. Dispositivo calcula `H = Hash(M || N || constante)`.
6. Dispositivo envia `H`.
7. Verificador compara `H` com o valor esperado usando o CRP armazenado.

## 6. Critérios de avaliação

- Verificação funcional do fluxo desafio-resposta.
- Consumo de recursos: ALMs, LUTs e registradores.
- Latência em ciclos de clock.
- Resistência a replay em simulação: nonce repetido deve ser rejeitado.
- Integração RO-PUF + FSM + mascaramento.

Não serão avaliadas métricas de caracterização física, como uniformidade, BER ou unicidade.
