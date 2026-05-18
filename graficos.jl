using Plots


function histograma_angulos(lista_angulos)
end


function plotar_trajetorias(matriz, parametros_impacto)
    # criar plot
    plt = plot(
        xlabel = "z",
        ylabel = "y",
        title = "Espalhamento Rutherford",
        legend = true,
    )

    cores = [:blue, :red, :cyan, :green, :yellow, :purple]


    for p in range(1, size(parametros_impacto)[1])
        # extrair b da lista de parametros
        b = parametros_impacto[p]
        matriz[2,1] = b  # mudar y0 para b

        # definir listas para guardar as trajetórias
        z_list, y_list = zeros(0), zeros(0)

        for t in range(2, N-1)
            matriz = atualizar(matriz, t, dt)
            append!(z_list, matriz[1, t])
            append!(y_list, matriz[3, t])
        end

        # plotar a trajetória
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
end
    