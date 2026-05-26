using Plots


function histograma_angulos(lista_angulos)
end


function mostrar_malha(malha)
    show(stdout, "text/plain", malha)
end
    

function plotar_trajetorias_(matriz, parametros_impacto, malha)
    # criar plot
    plt = plot(
        xlabel = "z",
        ylabel = "y",
        title = "Espalhamento Rutherford",
        legend = true,
        size=(1000, 600),
        xlims=(-15 * escala, 5 * escala),
        ylims=(-5 * escala, 5 * escala)
    )

    # definir cores para as trajetórias
    cores = [:blue, :red, :cyan, :green, :yellow, :purple]

    # plotar os átomos da malha
    xs = first.(malha)
    ys = last.(malha)
    scatter!(plt, xs, ys, color=:black, label="Átomos na malha", markersize=5)

    # lista de tuplas dos angulos de esapalhamento
    lista_angulos = zeros(0)

    # varrer os parametros de impacto
    for p in range(1, size(parametros_impacto)[1])   

        println("parametro de impacto: b = $(parametros_impacto[p])")

        b = parametros_impacto[p] # extrair b da lista de parametros
        matriz[2,1] = b  # mudar y0 para b

        # definir listas para guardar as trajetórias
        # z_list, y_list = zeros(0), zeros(0)

        for t in range(1, N-1)
            matriz = atualizar(matriz, t, malha)
        end
        
        # guardar os os parametros de impacto junto aos angulos de espalhamento
        append!(lista_angulos, (p, angulo_espalhamento(matriz)))


        z_list = [i for i in matriz[1, :]]
        y_list = [i for i in matriz[2, :]]
        # plotar a trajetória
        println("Plotando trajetória para b = $(b)...")

        plot!(
            plt,
            z_list,
            y_list,
            color = cores[p],
            label = "b = $(b)"
        )

    end

    # mostrar o gráfico final
    display(plt)

    #return lista_angulos
end


function plotar_z(matriz)
    # criar plot
    plt = plot(
        xlabel = "t",
        ylabel = "Posição em z (m)",
        title = "z X t",
        legend = true,
        size=(800, 600)
    )

    # extrair as velocidades z e y da matriz
    z_list = [i for i in matriz[1, :]]
    t_list = [i*dt for i in 1:size(matriz)[2]]

    # plotar as velocidades
    plot!(
        plt,
        t_list,
        z_list,
        color=:blue,
        label="Posição em z"
    )

    # mostrar o gráfico final
    display(plt)
end


function plotar_y(matriz)
    # criar plot
    plt = plot(
        xlabel = "t",
        ylabel = "y (m)",
        title = "y X t",
        legend = true,
        size=(800, 600)
    )

    # extrair as velocidades z e y da matriz
    y_list = [i for i in matriz[2, :]]
    t_list = [i*dt for i in 1:size(matriz)[2]]

    # plotar as velocidades
    plot!(
        plt,
        t_list,
        y_list,
        color=:red,
        label="Posição em y"
    )

    # mostrar o gráfico final
    display(plt)
end


function plotar_vz(matriz)
    # criar plot
    plt = plot(
        xlabel = "t",
        ylabel = "Velocidade em z (m/s)",
        title = "v_z X t",
        legend = true,
        size=(800, 600),
    )

    # extrair as velocidades z e y da matriz
    vz_list = [i for i in matriz[3, :]]
    t_list = [i*dt for i in 1:size(matriz)[2]]

    # plotar as velocidades
    plot!(
        plt,
        t_list,
        vz_list,
        color=:blue,
        label="Velocidade em z"
    )

    # mostrar o gráfico final
    display(plt)
end

function plotar_vy(matriz)
    # criar plot
    plt = plot(
        xlabel = "t",
        ylabel = "Velocidade em y (m/s)",
        title = "v_y X t",
        legend = true,
        size=(800, 600)
    )

    # extrair as velocidades z e y da matriz
    vy_list = [i for i in matriz[4, :]]
    t_list = [i*dt for i in 1:size(matriz)[2]]

    # plotar as velocidades
    plot!(
        plt,
        t_list,
        vy_list,
        color=:red,
        label="Velocidade em y"
    )

    # mostrar o gráfico final
    display(plt)
end
