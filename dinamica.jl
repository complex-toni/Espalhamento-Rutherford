# funcoes uteis para a dinamica do problema
# Como iremos resolver uma EDO de segunda ordem na posição, por conta da lei fundamental da dinâmica do problema:
# Função que calcula a distancia entre dois pontos num sistema de coordendas euclidiano bidimensional
function dist_bidimensional_(nuc_z, z_1, nuc_y, y_1)
    distz = nuc_z - z_1
    disty = nuc_y - y_1
    dist_bidimensional = √(distz^2 + disty^2)
    return dist_bidimensional
end


# Função que calcula o módulo da força elétrica entre a partícula alfa e o núcleo a uma certa distância
function modulo_forca_eletrica_nucleo_pAlfa(distancia)
    forca = k * (distancia^2)
    forca = k * (distancia^2)
    return forca
end


function atualizar(matriz, ti, dt)
    zi, yi, vzi, vyi = matriz[1,ti], matriz[2,ti], matriz[3,ti], matriz[4,ti]
    r = dist_bidimensional(zi, yi)

    # evitar singularidade na força em r=0
    if r < 1e-12
        r=1e-12
    end
    
    # calcular a aceleração
    F = modulo_forca_eletrica_nucleo_pAlfa(r)
    azi = (F * zi) / (m_alfa * r)
    ayi = (F * yi) / (m_alfa * r)

    # atualizar, de fato
    z = zi + vzi * dt * 1e-9
    y = yi + vyi * dt * 1e-9
    vz = vzi + azi * dt * 1e11
    vy = vyi + ayi * dt * 1e11

    matriz[1, ti+1] = z
    matriz[2, ti+1] = y
    matriz[3, ti+1] = vz
    matriz[4, ti+1] = vy

    return matriz

end    


# função para calcular o angulo de espalhamento a partir da matriz de estado
function angulo_espalhamento(matriz)
    zf::Float64 = matriz[1, N]
    yf::Float64 = matriz[2, N]
    ang_esp::Float64 = rad2deg(yf/zf)
    return ang_esp
end


function malha_atomica(shape::Tuple{Int,Int}, h)
    # a camada tem que ter simétrica por aproximação, portanto ímpar
    if isodd(shape[2]) == false
        println("Erro! A camada tem que ter simétrica por aproximação, portanto ímpar.")
    end

    ny, nz = shape   # rows, columns

    z = collect(0:h:(nz-1)*h)
    y = ((ny - 1)/2 .- (0:ny-1)) .* h

    malha = Matrix{Tuple{Float64,Float64}}(undef, ny, nz)

    for i in 1:ny
        for j in 1:nz
            malha[i, j] = (z[j], y[i])
        end
    end

    return malha

end
