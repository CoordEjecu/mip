# Ejemplo del libro Input-Output Analysis: Foundations and Extensions de Miller y Blair
# Capítulo 12.1: Supply Side Input–Output Models

Z <- matrix(c(225, 600, 110, 250, 125, 425, 325, 700, 150), nrow=3, byrow=TRUE)
x <- c(1200, 2000, 1500)
B <- diag(1/x) %*% Z # ¿Esta es A, la matriz insumo producto? Matriz de coeficiente de salida directa
A <- t(t(Z) / x)
G <- solve(diag(3) - B) # El modelo de Ghosh
G_t <- t(G)
