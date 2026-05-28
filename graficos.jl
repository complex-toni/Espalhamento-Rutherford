using Plots


function histograma_angulos(lista_angulos)
    plt = histogram(
        last.(lista_angulos),
        #weights=last.(lista_angulos),
        bins=20,
        #xlabel="Parâmetro de impacto (m)",
        ylabel="Ângulo de espalhamento (graus)",
        title="Histograma dos Ângulos de Espalhamento",
        legend=false,
        size=(800, 600)
    )

    println("Salvando histograma...")
    savefig(plt, "output/histograma_angulos.png")
    display(plt)
end


function mostrar_malha(malha)
    show(stdout, "text/plain", malha)
end
    

function plotar_trajetorias_(matriz, parametros_impacto, malha)
    # criar plot
    plt = plot(
        xlabel = "z",
        ylabel = "y",
        title = "Espalhamento Rutherford - b = $(comeco) a $(fim) (m) em $(valores) variações",
        legend = false,
        size=(2000, 1200),

        ylims=(-0.84e-8, 0.84e-8),
        xlims=(-0.5e-9, 1.67e-8),
        #ylims=(50.3222222e-11, 50.58888e-11),
        #xlims=(-5e-9, 2e-9),
        #ylims=(-5e-1 * escala, 5e-1 * escala)
    )

    # definir cores para as trajetórias
    #cores = [:blue, :red, :cyan, :green, :black, :purple, :orange, :brown, :grey, :pink]
    cores = palette(:viridis, size(parametros_impacto)[1])

    # plotar os átomos da malha
    xs = first.(malha)
    ys = last.(malha)
    scatter!(plt, xs, ys, color=:black, markersize=1, primary=false)

    # lista de tuplas dos angulos de esapalhamento
    lista_angulos = Vector{Vector{Float64}}()
    println(typeof(lista_angulos)) # vetor de tuplas (b, angulo_espalhamento) para guardar os parametros de impacto e os angulos de espalhamento correspondentes

    # varrer os parametros de impacto
    for p in range(start=1, stop=size(parametros_impacto)[1])   
        b = parametros_impacto[p] # extrair b da lista de parametros
        matriz[2,1] = b  # mudar y0 para b

        for t in range(1, N-1)
            matriz = atualizar(matriz, t, malha)
        end
        
        # guardar os os parametros de impacto junto aos angulos de espalhamento
        append!(lista_angulos, [[b, angulo_espalhamento(matriz)]])


        z_list = [i for i in matriz[1, :]]
        y_list = [i for i in matriz[2, :]]
        # y_list = [i for i in range(1,N)]
        # plotar a trajetória
        println("$(p)/$(size(parametros_impacto)[1]) -> b = $(b)")

        plot!(
            plt,
            z_list,
            y_list,
            color = cores[p],
            #label = "b = $(p)",
        )

        #scatter!(plt, z_list, y_list, color=:red, label="alfa", markersize=1)

    end

    # mostrar o gráfico final
    println("Salvando gráfico...")
    savefig(plt, "output/trajetorias.png")
    display(plt)

    return lista_angulos
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


# plotar energias
function plotar_energias(matriz)
    # extrair as energias cinética e potencial da matriz
    KE_list = df[:,:KE]
    V_list = df[:,:V]
    z_list = df[:,:z]
    # T_list = KE_list + V_list # energia total
    t_list = [i*dt for i in 1:size(matriz)[2]-1]

    # energias
    plt = plot(
        xlabel = "z (m)",
        ylabel = "Energia (J)",
        title = "Energias X t",
        legend = true,
        size=(800, 600),
    )

    # energia cinética
    plot!(
        plt,
        #t_list,
        z_list,
        KE_list,
        color=:blue,
        label="Energia Cinética",
        # ylims=(1.3e-13, 1.65e-13),
        # xlims=(6e-14, 9e-14)
    )

    savefig(plt, "output/energia_cinetica.png")
    display(plt)

    # energia potencial
    plt = plot(
    xlabel = "z (m)",
    ylabel = "Energia (J)",
    title = "Energias X t",
    legend = true,
    size=(800, 600)
    )

    plot!(
        plt,
        #t_list,
        z_list,
        V_list,
        color=:red,
        label="Energia Potencial",
        # ylims=(0, 3e-14),
        # xlims=(6e-14, 9e-14)
    )

    # plot!(
    #     plt,
    #     t_list,
    #     T_list,
    #     color=:green,
    #     label="Energia Total"
    # )

    # mostrar o gráfico final
    savefig(plt, "output/energia_potencial.png")
    display(plt)
end
