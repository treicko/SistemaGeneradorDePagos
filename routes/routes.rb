require "sinatra"
require "./lib/contrato_mensual"
require "./lib/empleado"
#index
get "/" do
	@empleados = [Empleado.new('1234567', 'Juan', 'Perez', Date.new(2012,1,1), ContratoMensual.new),Empleado.new('9876543', 'Jose', 'Sanchez', Date.new(2012,1,1), ContratoMensual.new)]

  erb :"index"
end