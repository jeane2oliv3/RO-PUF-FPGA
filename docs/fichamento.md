
### 3.2 `docs/fichamento.md`

```markdown
# Fichamento preliminar e lacuna de pesquisa

## 1. Objetivo

Registrar o levantamento bibliográfico inicial sobre RO-PUF, protocolos leves de autenticação e aplicações em IoT, além de identificar a lacuna que o TCC pretende endereçar.

## 2. Matriz de trabalhos relacionados

| Referência | Contribuição principal | Relação com este TCC |
|---|---|---|
| GASSEND et al., 2002 | Introduz o conceito de Physical Random Functions em silício. | Base conceitual para definir PUF. |
| SUH; DEVADAS, 2007 | PUF para autenticação de dispositivo e geração de chave. | Justifica o uso de PUF para autenticação. |
| HERDER et al., 2014 | Tutorial sobre PUFs e aplicações. | Fundamentação conceitual. |
| MAITI; SCHAUMONT, 2011 | RO-PUF aprimorada e amigável a FPGA. | Referência para arquitetura de RO. |
| XIN; KAPS; GAJ, 2011 | RO-PUF configurável para FPGAs Xilinx. | Mostra foco em Xilinx; a lacuna é Cyclone V. |
| KODÝTEK; LÓRENCZ, 2015 | Projeto de RO-PUF em FPGA com posicionamento e roteamento. | Ajuda nas constraints; não integra protocolo leve. |
| BOGDANOV et al., 2011 | SPONGENT: função hash leve. | Base para a função hash leve. |
| AYSU et al., 2015 | Protocolo de autenticação PUF end-to-end com privacidade. | Referência de protocolo de autenticação. |
| ZHUANG; LI, 2024 | Autenticação mútua leve baseada em PUF para IoT. | Referência de protocolo leve para IoT. |
| CHANDRAN; VIPIN, 2024 | Protocolo leve baseado em PUF para redes multi-UAV. | Mostra aplicação; não é Cyclone V. |
| SAYADI; ESHGHI, 2023 | RO-PUF configurável para segurança de IoT. | Trabalho relacionado recente. |
| GUPTA; NAZ; SHAH, 2024 | RO-PUF configurável com estabilidade térmica. | Foco em caracterização; este TCC não avalia métricas físicas. |
| WANG et al., 2025 | RO-PUF XNOR-XOR em ASIC 180 nm. | Comparação de arquitetura; não é FPGA. |
| APARICIO-TÉLLEZ et al., 2025 | RO-PUF resistente a aprendizado de máquina para IoT. | Atualiza o estado da arte. |
| YAVUZ et al., 2024 | Desafios de segurança de hardware para IoT. | Contextualização. |

## 3. Lacuna de pesquisa

A literatura recente demonstra esforço significativo no desenvolvimento de RO-PUFs em FPGAs, com trabalhos voltados a diferentes plataformas e objetivos, como estabilidade térmica, resistência a aprendizado de máquina e configurabilidade. Porém, grande parte dos estudos concentra-se em dispositivos Xilinx ou em análises isoladas de caracterização física e de consumo. Mesmo quando outras plataformas são exploradas para posicionamento e roteamento, observa-se escassez de trabalhos que apresentem o fluxo completo de implementação, integrando a RO-PUF a um protocolo leve de desafio-resposta, ambos descritos nativamente em SystemVerilog e otimizados para a família Intel Cyclone V.

Esta é a lacuna que este projeto pretende endereçar: uma solução integrada e aberta de RO-PUF + protocolo leve de autenticação, voltada a dispositivos embarcados de IoT com restrições severas de recursos.

