require File.expand_path(File.dirname(__FILE__) + '/empleado')
require File.expand_path(File.dirname(__FILE__) + '/generador_cheque')
require File.expand_path(File.dirname(__FILE__) + '/cheque')
require ('date')
require File.expand_path(File.dirname(__FILE__) + '/consola')

consola = Consola.new
generador = GeneradorCheque.new(Date.today, consola)
empleado =  Empleado.new
empleado.asignar_salario_fijo(1000)
empleado.con_nombre('juan')
empleado.con_apellido('perez')
empleado.con_ci('654321')
cheque = generador.ejecutar(empleado)
generador.imprimir_cheque(cheque)