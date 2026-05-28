# funcoes uteis para a dinamica do problema
# Como iremos resolver uma EDO de segunda ordem na posição, por conta da lei fundamental da dinâmica do problema:
# Função que calcula a distancia entre dois pontos num sistema de coordendas euclidiano bidimensional
function dist_bidimensional(z, y, nuc_z, nuc_y)
    distz = nuc_z - z
    disty = nuc_y - y
    dist_bidimensional = √(distz^2 + disty^2)
    return dist_bidimensional
end


function malha_atomica(shape::Tuple{Int,Int}, h)
    # a camada tem que ter simétrica por aproximação, portanto ímpar
    if isodd(shape[1]) == false
        println("Erro! A camada tem que ter simétrica por aproximação, portanto ímpar.")
        return
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


# função para calcular o angulo de espalhamento a partir da matriz de estado
function angulo_espalhamento(matriz)
    zf = matriz[1, end]
    yf = matriz[2, end]
    ang_esp = rad2deg(atan(yf/zf)) # deixar entre -180 e 180 graus
    return ang_esp
end

# energia cinética
function energia_cinetica(matriz, i)
    KE = 0.5 * m_alfa * (matriz[3,i] * matriz[3,i] + matriz[4,i] * matriz[4,i])
    return KE
end


# energia potencial
function energia_potencial(matriz, i, malha)
    V = 0.0
    for nuc in malha
        nuc_z, nuc_y = nuc
        r = dist_bidimensional(matriz[1,i], matriz[2,i], nuc_z, nuc_y)
        V += k * (1/r)
    end

    return V
end


# Função que calcula o módulo da força elétrica entre a partícula alfa e o núcleo a uma certa distância
function modulo_forca_eletrica_nucleo_pAlfa(z, y, malha)
    az, ay = 0.0, 0.0  # componentes da aceleração

    for i in 1:size(malha)[1]
        for j in 1:size(malha)[2]
            nuc_z, nuc_y = malha[i, j]
            r = dist_bidimensional(z, y, nuc_z, nuc_y)
            
            # evitar singularidade na força em r=0
            if r < 1e-15
                r = 1e-15
            end
             
            # calcular o modulo da força
            F = k * (1/(r^2 + epsilon_quad))

            # somar as componentes da aceleração
            az += (F * (z - nuc_z)) / (m_alfa * r)
            ay += (F * (y - nuc_y)) / (m_alfa * r)
        end
    end

    # println("az = $(az), ay = $(ay)")
    return az, ay
end


function atualizar(matriz, ti, malha)
    zi, yi, vzi, vyi = matriz[1,ti], matriz[2,ti], matriz[3,ti], matriz[4,ti]

    # calcular a aceleração
    azi, ayi = modulo_forca_eletrica_nucleo_pAlfa(zi, yi, malha)

    # if ti==1
    #     println("posição inicial: z = $(zi), y = $(yi)")
    #     println("velocidade inicial: vz = $(vzi), vy = $(vyi)")
    #     println("aceleração inicial: az = $(azi), ay = $(ayi)")
    # end

    # atualizar, de fato
    z = zi + (vzi * dt)
    y = yi + (vyi * dt)
    vz = vzi + (azi * dt)
    vy = vyi + (ayi * dt)

    matriz[1, ti+1] = z
    matriz[2, ti+1] = y
    matriz[3, ti+1] = vz
    matriz[4, ti+1] = vy
    
    # adicionar ao arquivo de saída (fica ruim com o t junto)
    #info = "[z = $(zi), y = $(yi)], [vz = $(vzi), vy = $(vyi)], [az = $(azi), ay = $(ayi)]"
    #append!(linhas, [info])

    # calcular energias
    KEi = energia_cinetica(matriz, ti)
    Vi = energia_potencial(matriz, ti, malha)

    if valores == 1
        # adicionar ao dataframe
        push!(df, (
            t = ti*dt,
            z = zi,
            y = yi,
            vz = vzi,
            vy = vyi,
            az = azi,
            ay = ayi,
            KE = KEi,
            V = Vi
        ))
    end

    return matriz

end    

