% Mundo dos Blocos - Implementação baseada em busca em grafo
% Autor: Marcelo Leda, Jean Seixas
% Data: [Data Atual]
% Descrição: Este código implementa um planejador para o problema do Mundo dos Blocos,
%            considerando blocos de diferentes tamanhos e restrições de estabilidade.

% Definição dos blocos e seus tamanhos
bloco(a, 2).
bloco(b, 1).
bloco(c, 3).
bloco(d, 4).

% Predicado plano/3: Gera um plano para atingir um conjunto de metas
% plano(Estado, Metas, Plano)
% Estado: Estado atual do mundo
% Metas: Lista de metas a serem alcançadas
% Plano: Lista de ações para alcançar as metas
plano(Estado, [], []).
plano(Estado, [Meta|Metas], Plano) :-
    solve(Estado, Meta, Acoes),
    append(Acoes, PlanoResto, Plano),
    aplicar_acoes(Acoes, Estado, NovoEstado),
    plano(NovoEstado, Metas, PlanoResto).

% solve/3: Encontra ações para atingir uma meta específica
% solve(Estado, Meta, Acoes)
% Estado: Estado atual do mundo
% Meta: Meta a ser alcançada
% Acoes: Lista de ações para alcançar a meta
solve(Estado, on(Bloco, Destino), [move(Bloco, Origem, Destino)]) :-
    bloco(Bloco, _),
    member(on(Bloco, Origem), Estado),
    diferente(Origem, Destino),
    livre(Bloco, Estado),
    livre(Destino, Estado),
    estavel(Bloco, Destino).
solve(Estado, on(Bloco, Destino), [move(BlocoAcima, Bloco, mesa), move(Bloco, Origem, Destino)]) :-
    bloco(Bloco, _),
    member(on(Bloco, Origem), Estado),
    member(on(BlocoAcima, Bloco), Estado),
    diferente(Origem, Destino),
    livre(BlocoAcima, Estado),
    livre(Destino, Estado),
    estavel(Bloco, Destino).

% Predicados auxiliares

% livre/2: Verifica se um bloco está livre (nenhum bloco sobre ele)
livre(Bloco, Estado) :-
    bloco(Bloco, _),
    \+ member(on(_, Bloco), Estado).

livre(mesa, _).

% diferente/2: Verifica se dois objetos são diferentes
diferente(X, Y) :- X \= Y.

% estavel/2: Verifica se um bloco pode ser colocado de forma estável sobre outro
estavel(Bloco, mesa) :- !.
estavel(Bloco, Suporte) :-
    bloco(Bloco, TamanhoBloco),
    bloco(Suporte, TamanhoSuporte),
    TamanhoBloco =< TamanhoSuporte.

% aplicar_acoes/3: Aplica uma sequência de ações ao estado
aplicar_acoes([], Estado, Estado).
aplicar_acoes([Acao|Acoes], Estado, NovoEstado) :-
    aplicar(Acao, Estado, EstadoIntermediario),
    aplicar_acoes(Acoes, EstadoIntermediario, NovoEstado).

% aplicar/3: Aplica uma única ação ao estado
aplicar(move(Bloco, Origem, Destino), Estado, NovoEstado) :-
    delete(Estado, on(Bloco, Origem), EstadoTemp),
    adicionar_ordenado(on(Bloco, Destino), EstadoTemp, NovoEstado).

% adicionar_ordenado/3: Adiciona um elemento a uma lista mantendo a ordem
adicionar_ordenado(X, [], [X]).
adicionar_ordenado(X, [Y|Ys], [X,Y|Ys]) :- X @< Y, !.
adicionar_ordenado(X, [Y|Ys], [Y|Zs]) :- adicionar_ordenado(X, Ys, Zs).

% Estados iniciais e finais para os cenários da Situação 1
estado_inicial(i1, [on(a,mesa), on(b,mesa), on(c,mesa), on(d,mesa)]).
estado_inicial(i2, [on(a,b), on(b,mesa), on(c,d), on(d,mesa)]).

estado_final(i2, [on(c,d), on(d,mesa), on(a,b), on(b,mesa)]).
estado_final(i2b, [on(d,c), on(c,a), on(a,mesa), on(b,mesa)]).

% resolver_cenario/3: Resolve um cenário específico
% resolver_cenario(Inicial, Final, Plano)
% Inicial: Identificador do estado inicial
% Final: Identificador do estado final
% Plano: Lista de ações para ir do estado inicial ao final
resolver_cenario(Inicial, Final, Plano) :-
    estado_inicial(Inicial, EstadoInicial),
    estado_final(Final, EstadoFinal),
    findall(Meta, member(Meta, EstadoFinal), Metas),
    plano(EstadoInicial, Metas, PlanoReverso),
    reverse(PlanoReverso, Plano).

% Exemplo de uso
:- 
    resolver_cenario(i1, i2, Plano),
    writeln('Plano para i1 até i2:'),
    maplist(writeln, Plano).
