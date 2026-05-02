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
