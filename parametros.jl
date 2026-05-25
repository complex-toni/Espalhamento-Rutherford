# Parâmetros do problema
dt::Float64 = 3*1e-15 # passo em fs. # valor normal = 300*1e-15
K0::Float64 = 1.602*1e-13 # Energia cinética inicial da particula alfa - em J (Equivalente a 1 MeV)
# Iremos assumir que o núcleo encontra-se na origem do sistema de coordenadas e tem posições fixas.
z0::Float64 = -10*1e-6 # Componente z da posição inicial do núcleo (a t = t0) - em m - Assumimos eixo z paralelo ao momentum inical da partícula
y0::Float64 = 0.0 # Componente y da posição inicial do núcleo (a t = t0) - em m
m_alfa::Float64 = 6.645*1e-27 # Massa da partícula alfa em kg
e0::Float64 = 8.854*1e-12 # Coeficiente de permissividade elétrica do vácuo - em C^2/(N*m^2)
N_atomico::Int64 = 79 #Número atômico do ouro
carga_eletron::Float64 = 1.602*1e-19 # Carga elementar em C
v0_z::Float64 =  √((2*K0)/m_alfa) # Velocidade inicial da partícula alfa, na direção z (inicialmente, só há velocidade na direção z) - m/s
v0_y::Float64 = 0.0 # Velocidade inicial da partícula alfa, na direção y (inicialmente, só há velocidade na direção z) - m/s
q_alfa::Float64 = 2*carga_eletron
q_nucleo:: Float64 = N_atomico*carga_eletron
k::Float64 = (q_alfa * q_nucleo)/(4*π*e0)

N::Int64 = 1000 # Número de passos a serem calculados na simulacao.
u = Matrix{Float64}(undef, 4, N) # Matrix com as posições e velocidades bidimensionais via método da EDO por diferenças finitas

#Inicialização dos parâmetros
u[1, 1] = z0 # Condição inicial para a componente z da posição da particula alfa
u[2, 1] = y0 # Condição inicial para a componente y da posição da particula alfa
u[3, 1] = v0_z # Condição inicial para a componente z da velocidade da particula alfa
u[4, 1] = v0_y # Condição inicial para a componente z da velocidade da particula alfa

# parametros_impacto = [
#         # -1.02e-13,
#         # -1.01e-13,
#         # -1.e-13,
#         0.0,
#          1e-13,
#          1.01e-13,
#          1.02e-1
#     ]

escala = 1e-15

parametros_impacto = [2.5 * escala]

# definir a geometria da malha atômica (input)
n_atomos_por_camada = 1
n_camadas = 1
distancia_entre_atomos = 1 * escala