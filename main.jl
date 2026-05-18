# Neste script acontecerá a rotina principal do modelo

# importar variáveis e parâmetros dos outros módulos
include("parametros.jl")
include("dinamica.jl")
include("graficos.jl")

println(dt)
println(m_alfa)

plotar_trajetorias(u, parametros_impacto)
