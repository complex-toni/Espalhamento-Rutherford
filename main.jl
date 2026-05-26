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

plotar_z(u)
plotar_y(u)
plotar_vz(u)
plotar_vy(u)

# gerar arquivo de saída
open("saida.txt", "w") do f
    for linha in linhas
        write(f, linha * "\n")
    end
end

# gerar arquivo de saída em formato csv
CSV.write("saida.csv", df, delim=';')

# limpar terminal:
# print("\033c")