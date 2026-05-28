using Plots

plt = plot(
        xlabel = "z",
        ylabel = "y",
        title = "Espalhamento Rutherford",
        legend = true,
        size=(1000, 600),
        #xlims=(-15 * escala, 5 * escala),
        #ylims=(-5e-1 * escala, 5e-1 * escala)
    )

x = [i for i in range(1,50)]
y = [i^2 for i in range(1,50)]


"""plot!(
            plt,
            x,
            y,
            label = "b = "
        )"""
scatter!(plt, x, y, color=:red, label="alfa", markersize=5)
display(plt)