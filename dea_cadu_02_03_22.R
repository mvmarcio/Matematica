# Mudando o diretorio
setwd("~/Mestrado/2022/Cadu_UnB")

# Usando so recursos instalados
library(Benchmarking) # pacote para a analise envoltoria de dados.
library(ucminf) # para juncao dos dados.
library(lpSolveAPI) # para puxar dados por API.
library(dplyr) # para organizacao dos dados
library(openxlsx) # para exportar dados para Excel.
library(readxl) # para leitura de dados em Excel.

# Manual DEA - Piter Borgetorf
# https://cran.r-project.org/web/packages/Benchmarking/Benchmarking.pdf

# lendo a base de dados
dados_dea <- dados_dea <- read_excel("base_dea.xlsx")

####################################################################
# Segregando dos dados por ano para calculo do DEA

#Input
nome <- subset(dados_dea, select = c("dmu"))

dados_inp <- subset(dados_dea,
                   select = c("input"))
#Output
dados_out <- subset(dados_dea,
                         select = c("output"))
                              

# Transformando os dados em numericos - para estimar
dados_inp <- data.frame(dados_inp)
dados_out <- data.frame(dados_out)

# resultado
dea_21 <- dea(dados_inp, dados_out, RTS = "vrs", ORIENTATION = "out")

# salvando os resultados da eficiencia 
saida_dea <- 1/dea_21$eff
saida_dea <- data_frame(saida_dea)
saida_dea <- cbind(saida_dea, nome)

# calculando os benchimark
bench <- print(peers(dea_21, NAMES = T), quote = F)
bench <- data_frame(bench)
bench <- cbind(bench, nome)
resultado <- merge(saida_dea, 
                      by=c("dmu"))

# na pasta em que estao os dados ira aparecer uma planilha com o nome resultado
write.xlsx(saida_dea,"resultado_dea2.xlsx")
############################  FIM   ##########################
