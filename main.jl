# Neste script acontecerá a rotina principal do modelo

# importar variáveis e parâmetros dos outros módulos
include("parametros.jl")
include("dinamica.jl")
include("graficos.jl")


println("Rodando simulação...")

# criar malha
malha = malha_atomica((n_atomos_por_camada, n_camadas), distancia_entre_atomos)
#mostrar_malha(malha) # verificar as posicoes atomicas na malha

# plotar as trajetórias e o histograma dos angulos de espalhamento
angulos_espalhamento = plotar_trajetorias_(u, parametros_impacto, malha)
histograma_angulos(angulos_espalhamento)

#plotar_z(u)
#plotar_y(u)
#plotar_vz(u)
#lotar_vy(u)

# plotar energias se for só uma partícula
if valores ==1
    println("Plotando energias...")
    plotar_energias(u)
end

println("Exportando dados...")
# gerar arquivo de saída
# open("output/saida.txt", "w") do f
#     for linha in linhas
#         write(f, linha * "\n")
#     end
# end

# gerar arquivo de saída em formato csv
# CSV.write("output/saida.csv", df, delim=';')

# salvar angulos
open("output/angulos.txt", "w") do f
    write(f, "b;a\n")
    for (p, a) in angulos_espalhamento
        write(f, "$(p);$(a)\n")
    end
end

println("Finalizado.")

# limpar terminal:
# print("\033c")