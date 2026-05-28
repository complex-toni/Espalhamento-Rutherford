using DataFrames
using CSV


# Parâmetros do problema
m_alfa::Float64 = 6.645*1e-27 # Massa da partícula alfa em kg
e0::Float64 = 8.854*1e-12 # Coeficiente de permissividade elétrica do vácuo - em C^2/(N*m^2)
N_atomico::Int64 = 79 #Número atômico do ouro
carga_eletron::Float64 = 1.602*1e-19 # Carga elementar em C

q_alfa::Float64 = 2*carga_eletron
q_nucleo:: Float64 = N_atomico*carga_eletron
k::Float64 = (q_alfa * q_nucleo)/(4*π*e0)

# fator de suavização para evitar singularidade na força em r<=1e-15
epsilon_quad::Float64 = (1e-14)^2

escala = 1e-10 # angstrom

tf::Float64 = 1.4e-14 # tempo final da simulação em s

# Parâmetros de simulação
dt::Float64 = 1e-19 # passo em fs. # valor normal = 1e-20
K0::Float64 = 1.602*1e-13 # Energia cinética inicial da particula alfa - em J (Equivalente a 1 MeV)

# Iremos assumir que o núcleo encontra-se na origem do sistema de coordenadas e tem posições fixas.
z0::Float64 = -500e-10 # Componente z da posição inicial do núcleo (a t = t0) - em m - Assumimos eixo z paralelo ao momentum inical da partícula
y0::Float64 = 0.0 # Componente y da posição inicial do núcleo (a t = t0) - em m

v0_z::Float64 =  √((2*K0)/m_alfa) # Velocidade inicial da partícula alfa, na direção z (inicialmente, só há velocidade na direção z) - m/s
v0_y::Float64 = 0.0 # Velocidade inicial da partícula alfa, na direção y (inicialmente, só há velocidade na direção z) - m/s

#N::Int64 = 1.4e6 # Número de passos a serem calculados na simulacao. # 1.4e6
N = round(Int, tf/dt) # Número de passos a serem calculados na simulação. # 1.4e6
u = Matrix{Float64}(undef, 4, N) # Matrix com as posições e velocidades bidimensionais via método da EDO por diferenças finitas

#Inicialização dos parâmetros
u[1, 1] = z0 # Condição inicial para a componente z da posição da particula alfa
u[2, 1] = y0 # Condição inicial para a componente y da posição da particula alfa
u[3, 1] = v0_z # Condição inicial para a componente z da velocidade da particula alfa
u[4, 1] = v0_y # Condição inicial para a componente y da velocidade da particula alfa

#### GERAR PARÂMETROS DE IMPACTO ####
# gerar uma lista de parâmetros de impacto
comeco = 0.200e-10
fim = 0.000900e-10
valores = 500

function gerar_parametros_impacto(comeco, fim, valores)
    parametros = [i for i in range(start=comeco, stop=fim, length=valores)]
    return parametros
end

parametros_impacto = gerar_parametros_impacto(comeco, fim, valores)

#### MALHA ATÔMICA ####
# definir a geometria da malha atômica (input)
n_atomos_por_camada = 101
n_camadas = 100
distancia_entre_atomos = 1.66e-10

#### OUTPUT ####
linhas = Vector{String}() # vetor de strings para guardar as linhas do arquivo de saída

# dataframe para guardar os dados da simulação
############## IMPORTANTE ################
# O df funciona bem para uma única partícula alfa, 
# mas não reseta para mais de uma partícula
###########################################
df = DataFrame(
    t  = Float64[],
    z  = Float64[],
    y  = Float64[],
    vz = Float64[],
    vy = Float64[],
    az = Float64[],
    ay = Float64[],
    KE = Float64[],
    V = Float64[]
)
