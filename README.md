# ReadMe

# Notas importantes

## Simulação de 1 partícula alfa (apenas um b):

- Mudar linha 54 do parametros.jl para :

“parametros_impacto = gerar_parametros_impacto(comeco, comeco, valores)”

- O parâmetro de impacto (b) será o “comeco”, na linha 45

## Simulação de N partículas:

- O dataframe (df) NÃO FUNCIONA. Ele vai adicionando mais valores pra cada b.
Isso quer dizer que tanto os gráficos de energia quanto a saída em .csv não funcionam.

## Simulação de 1 núcleo:
- - Os valores nas linhas 58 e 59 têm que ser mudados ambos para 1 e 1.   # 
  