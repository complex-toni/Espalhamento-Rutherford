using Plots


function histograma_angulos(lista_angulos)
end
    

function plotar_trajetorias_(matriz, parametros_impacto, malha)
    # criar plot
    plt = plot(
        xlabel = "z",
        ylabel = "y",
        title = "Espalhamento Rutherford",
        legend = true,
    )

    cores = [:blue, :red, :cyan, :green, :yellow, :purple]

    # lista de tuplas dos angulos de esapalhamento
    lista_angulos = zeros(0)

    for p in range(1, size(parametros_impacto)[1])   
        # extrair b da lista de parametros
        b = parametros_impacto[p]
        matriz[2,1] = b  # mudar y0 para b

        # definir listas para guardar as trajetórias
        z_list, y_list = zeros(0), zeros(0)

        for t in range(2, N-1)
            matriz = atualizar(matriz, t, dt, malha)
            append!(z_list, matriz[1, t])
            append!(y_list, matriz[3, t])
        end
        
        # guardar os os parametros de impacto junto aos angulos de espalhamento
        append!(lista_angulos, (p, angulo_espalhamento(matriz)))

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

    #return lista_angulos
end


function mostrar_malha(malha)
    show(stdout, "text/plain", malha)
end