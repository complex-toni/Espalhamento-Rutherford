# funcoes uteis para a dinamica do problema
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
