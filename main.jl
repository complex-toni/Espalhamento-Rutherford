# Neste script acontecerá a rotina principal do modelo

# importar variáveis e parâmetros dos outros módulos
include("parametros.jl")
include("dinamica.jl")
include("graficos.jl")


println("Rodando simulação...")

# criar malha
malha = malha_atomica((n_atomos_por_camada, n_camadas), distancia_entre_atomos)
# verificar as posicoes atomicas na malha
mostrar_malha(malha)

# plotar as trajetórias e o histograma dos angulos de espalhamento
plotar_trajetorias_(u, parametros_impacto, malha)
