# Script para simular espalhamento Rutherford (Inicialmente faremos a simulação em duas dimensões).
#------------------------------------------------------------------------------------------------------------------------------------
# Parâmetros do problema
t0::Float64 = 0.0 # início do interval temporal *Atentar/Verificar a escala de tempo típica do problema*
tn::Float64 = 10.0 # final do interval temporal em *Atentar/Verificar a escala de tempo típica do problema*
dt::Float64 = 0.05 # passo em s de discretização do interval [t0, t1]
K0::Float64 = 0.0 # Energia cinética inicial da particula alfa *Em escrever em J*
# Iremos assumir que o núcleo encontra-se na origem do sistema de coordenadas e tem posições fixas.
z0::Float64 = 0.0 # Componente z da posição inicial do núcleo (a t = t0) em m - Assumimos eixo z paralelo ao momentum inical da partícula
y0::Float64 = 0.0 # Componente y da posição inicial do núcleo (a t = t0) em m
m_alfa::Float64 = 6.645 # Massa da partícula alfa em kg * 10^-27
e0::Float64 = 8.854 # Coeficiente de permissividade elétrica do vácuo - C^2/(N*m^2)
N_atomico::Int64 = 79 #Número atômico do ouro
carga_eletron::Float64 = 1.602 # Carga elementar em C * 10^-19
N::Int64 = Int64(round((tn - t0)/dt + 1))
v0_z = √((2*K0)/m_alfa) # Velocidade inicial da partícula alfa, na direção z (inicialmente, só há velocidade na direção z)
v0_y ::Float64 = 0.0 # Velocidade inicial da partícula alfa, na direção y (inicialmente, só há velocidade na direção z)
u = Matrix{Float64}(undef, 4, N) # Matrix com as posições e velocidades bidimensionais via método da EDO por diferenças finitas
constante = (2*N_atomico*carga_eletron^2)/(4*π*e0)
#------------------------------------------------------------------------------------------------------------------------------------
#Inicialização dos parâmetros
u[1, 1] = z0 # Condição inicial para a componente z da posição da particula alfa
u[2, 1] = y0 # Condição inicial para a componente y da posição da particula alfa
u[3, 1] = v0_z # Condição inicial para a componente z da velocidade da particula alfa
u[4, 1] = v0_y # Condição inicial para a componente z da velocidade da particula alfa
#------------------------------------------------------------------------------------------------------------------------------------
# Bloco reservado para funções úteis para o problema:
# Como iremos resolver uma EDO de segunda ordem na posição, por conta da lei fundamental da dinâmica do problema:
# Função que calcula a distancia entre dois pontos num sistema de coordendas euclidiano bidimensional
function dist_bidimensional(z_1, y_1)
    dist_bidimensional = √(z_1^2 + y_1^2)
    return dist_bidimensional
end

function EDO_diferencas_finitas_2D(matriz, parametro, dt)
    distancia_cubo = dist_bidimensional(matriz[1, parametro -1], matriz[2, parametro -1])^3
    posicao_z = matriz[1, parametro -1]+ matriz[3, parametro -1]*dt
    velocidade_z = matriz[3, parametro -1]+ (constante/distancia_cubo)*matriz[1, parametro -1]*dt
    posicao_y = matriz[2, parametro -1]+ matriz[4, parametro -1]*dt
    velocidade_y = matriz[4, parametro -1]+ (constante/distancia_cubo)*matriz[2, parametro -1]*dt
    return posicao_z, posicao_y, velocidade_z, velocidade_y
end


# Função que calcula o módulo da força elétrica entre a partícula alfa e o núcleo a uma certa distância
function modulo_forca_eletrica_nucleo_pAlfa(q_nucleo, distancia)
    constante = 1/(4*π*e0)
    forca = constante*(2*q_nucleo*e^2)/(distancia^2)
    return forca
end

# Programa principal

    #Etapas a implementar no código
        # 1 - Criar funções para a força eletromagnética;
        # 2 - Setar inicialmente as posições e momentum das partículas alfa e posição do nucleo de ouro (definir se será feito com ouro)
        # 3 - Atualizar a posição devido a interação;
        # 4 - Pensar sobre as posições do "anteparo/medidores" - caso seja esférico podemos fazer uma comparação com os resultados reais de Rutherford
        # 5 - Criar um histograma para as particulas espalhadas;
        # 6 -  Criar um gráfico com uma coleção de trajetórias; (estatistica - milhares ou dezenas de milhares de runs);
        # 7 - Criar uma função força eletrica para usar no caso de um cristal de ouro.