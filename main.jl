# Neste script acontecerá a rotina principal do modelo

# importar variáveis e parâmetros dos outros módulos
include("parametros.jl")
include("dinamica.jl")
include("graficos.jl")


println("Rodando simulação...")


# verificar as posicoes atomicas na malha
malha = malha_atomica((3,3),1)
mostrar_malha(malha)

# rodar a rotina dependendo do tipo de espalhamento
if tipo_sim == "único átomo"
    #plotar_trajetorias(u, parametros_impacto)
elseif tipo_sim == "malha atômica"
    pass
else
    println("Esta simulação não existe.")
end
