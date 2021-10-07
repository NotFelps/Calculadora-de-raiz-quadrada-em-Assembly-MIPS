.data
	x: .double 100.0                   # n�mero que se deseja calcular a ra�z
	x2: .double 2.0                   # usado para a divis�o n/2
	x0: .double 0.0                   # apenas o valor 0, usado em algumas atribui��es
	prec: .double 0.0000001           # precis�o desejada no c�lculo
	erro: .double -1.0                # valor em caso de erro
.text
	
	ldc1 $f0, x          	           # coloca x em $f0
	ldc1 $f14, x2                     # coloca x2 em $f14
	ldc1 $f16, x0                     # coloca x0 em $f16 
	ldc1 $f28, prec     	           # coloca prec em $f28
	ldc1 $f24, erro
	
	raizQuadrada:
	
	c.eq.d $f0, $f16 		   #caso o valor inserido em " x " seja 0, redireciona para o c�digo de exit
	bc1t exit
	
	c.lt.d $f0, $f16                  #caso o valor inserido em " x " seja negativo, redireciona para o c�digo de erro ("erroF")
	bc1t erroF                          
	
	div.d $f2, $f0, $f14               # x = n / 2

	while:
		add.d $f20, $f2, $f16      # x = xanterior ( $f20 = xanterior )
		mul.d $f6, $f2, $f2        # $f6 = (x * x)
		add.d $f8, $f6, $f0        # $f8 = ((x*x) + n)
		mul.d $f10, $f14, $f2      # $f10 = (2 * x)
		div.d $f2, $f8, $f10       # $f2 = ((x*x+n) / (2*x))
		sub.d $f30, $f2, $f20      # $f30 = (x - xanterior)
		abs.d $f22, $f30           # $f22 = Math.abs(x - xanterior)
		c.lt.d $f22, $f28          # if($f22 < $f28) // condi��o do While
		bc1t exit                  # se a condi��o acima for verdadeira, desvia o c�digo para "exit"
	
	j while                            # comando usado para voltar a fun��o "while", realizando assim o loop
	
	exit:                              # c�digo de sa�da da fun��o, com a resposta
	
		mov.d  $f12, $f2           # comando print com a resposta do problema
		li $v0, 3
		syscall
		
		li $v0, 10	           # c�digo para encerrar o programa
		syscall	
		# fim do programa, a resposta da fun��o se encontra em $f2
	
	erroF:                            # c�digo de erro da fun��o
		
		mov.d $f12, $f24
		li $v0, 3
		syscall
		# fim do programa em caso de erro (valor negativo)
	
	
	
	
