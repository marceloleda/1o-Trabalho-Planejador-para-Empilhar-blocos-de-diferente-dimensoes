Marcelo Ferreira Leda Filho
</br>
Juan Seixas
# Mundo dos Blocos - Planejador em Prolog

Este repositório contém uma implementação em Prolog de um planejador para o problema do Mundo dos Blocos, considerando blocos de diferentes tamanhos e restrições de estabilidade.

## Pré-requisitos

- SWI-Prolog (versão 8.0 ou superior)

## Como executar

1. Clone este repositório:
   ```
   git clone https://github.com/seu-usuario/mundo-dos-blocos-prolog.git
   cd mundo-dos-blocos-prolog
   ```

2. Inicie o SWI-Prolog:
   ```
   swipl
   ```

3. Carregue o arquivo do programa:
   ```prolog
   [mundo_dos_blocos].
   ```

4. Para resolver um cenário específico, use o predicado `resolver_cenario/3`. Por exemplo:
   ```prolog
   ?- resolver_cenario(i1, i2, Plano).
   ```

5. Para testar todos os cenários da Situação 1, execute:
   ```prolog
   ?- resolver_cenario(i1, i2, Plano1),
      writeln('Plano para i1 até i2:'),
      maplist(writeln, Plano1),
      resolver_cenario(i2, i2, Plano2),
      writeln('Plano para i2 até i2:'),
      maplist(writeln, Plano2),
      estado_inicial(i2, EstadoInicial),
      plano(EstadoInicial, [on(d,c), on(c,a), on(a,mesa), on(b,mesa)], Plano3),
      writeln('Plano para i2 até i2 (b):'),
      maplist(writeln, Plano3).
   ```

## Estrutura do código

- `bloco/2`: Define os blocos e seus tamanhos
- `plano/3`: Gera um plano para atingir um conjunto de metas
- `solve/3`: Encontra ações para atingir uma meta específica
- `livre/2`, `diferente/2`, `estavel/2`: Predicados auxiliares
- `aplicar_acoes/3`, `aplicar/3`: Aplicam ações ao estado
- `estado_inicial/2`, `estado_final/2`: Definem os estados iniciais e finais
- `resolver_cenario/3`: Resolve um cenário específico
