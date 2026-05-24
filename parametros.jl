# Parâmetros do problema
dt::Float64 = 300 # passo em fs.
K0::Float64 = 1.602 # Energia cinética inicial da particula alfa - 10^-13 J (Equivalente a 1 MeV)
# Iremos assumir que o núcleo encontra-se na origem do sistema de coordenadas e tem posições fixas.
z0::Float64 = 0.0 # Componente z da posição inicial do núcleo (a t = t0) - 10^-3 m (1 mm) - Assumimos eixo z paralelo ao momentum inical da partícula
y0::Float64 = 0.0 # Componente y da posição inicial do núcleo (a t = t0) - 10^-3 m (1 mm)
m_alfa::Float64 = 6.645 # Massa da partícula alfa em kg * 10^-27 kg
e0::Float64 = 8.854 # Coeficiente de permissividade elétrica do vácuo - 10^-12 [C^2/(N*m^2)]
N_atomico::Int64 = 79 #Número atômico do ouro
carga_eletron::Float64 = 1.602 # Carga elementar em C * 10^-19
N::Int64::Int64 = 3000 # Número de passos a serem calculados na simulacao.
v0_z:: Float64 =  √((2*K0)/m_alfa) # Velocidade inicial da partícula alfa, na direção z (inicialmente, só há velocidade na direção z) - ordem de 10^6 (m/s)
v0_y ::Float64 = 0.0 # Velocidade inicial da partícula alfa, na direção y (inicialmente, só há velocidade na direção z)
u = Matrix{Float64}(undef, 4, N) # Matrix com as posições e velocidades bidimensionais via método da EDO por diferenças finitas
q_alfa::Float64 = 2*carga_eletron
q_nucleo:: Float64 = N_atomico*carga_eletron
k::Float64 = (q_alfa * q_nucleo)/(4πe0)

#Inicialização dos parâmetros
u[1, 1] = z0 # Condição inicial para a componente z da posição da particula alfa
u[2, 1] = y0 # Condição inicial para a componente y da posição da particula alfa
u[3, 1] = v0_z # Condição inicial para a componente z da velocidade da particula alfa
u[4, 1] = v0_y # Condição inicial para a componente z da velocidade da particula alfa

parametros_impacto = [
        -5e-14,
        -3e-14,
        -1e-14,
         1e-14,
         3e-14,
         5e-14
    ]

# definir dicionário para os tipos de simulação
tipo_dict = Dict(
        1 => "único átomo",
        2 => "malha atômica"
)

# definir o tipo de simulação
tipo_sim = tipo_dict[1]  # mudar apenas o número

