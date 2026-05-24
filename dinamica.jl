# funcoes uteis para a dinamica do problema
# Como iremos resolver uma EDO de segunda ordem na posição, por conta da lei fundamental da dinâmica do problema:
# Função que calcula a distancia entre dois pontos num sistema de coordendas euclidiano bidimensional
function dist_bidimensional(z_1, y_1)
    dist_bidimensional = √(z_1^2 + y_1^2)
    return dist_bidimensional
end


# Função que calcula o módulo da força elétrica entre a partícula alfa e o núcleo a uma certa distância
function modulo_forca_eletrica_nucleo_pAlfa(distancia)
    k = 1/(4*π*e0)
    q_nucleo = N_atomico * -carga_eletron
    forca = k * (2 * q_nucleo * carga_eletron)/(distancia^2)
    return forca
end


function atualizar(matriz, ti, dt)
    zi, yi, vzi, vyi = matriz[1,ti], matriz[2,ti], matriz[3,ti], matriz[4,ti]
    r = dist_bidimensional(zi, yi)

    # evitar singularidade na força em r=0
    if r < 1e-15
        r=1e-15
    end
    
    # calcular a aceleração
    F = modulo_forca_eletrica_nucleo_pAlfa(r)
    azi = (F * zi) / (m_alfa * r)
    ayi = (F * yi) / (m_alfa * r)

    # atualizar, de fato
    z = zi + vzi * dt
    y = yi + vyi * dt
    vz = vzi + azi * dt
    vy = vyi + ayi * dt

    matriz[1, ti+1] = z
    matriz[2, ti+1] = y
    matriz[3, ti+1] = vz
    matriz[4, ti+1] = vy

    return matriz

end    


# função para calcular o angulo de espalhamento a partir da matriz de estado
function angulo_espalhamento(matriz)
    
end
