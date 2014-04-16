require('date')
require 'sinatra'
require './lib/empleado'
require './lib/contrato_mensual'
require './lib/contrato_quincenal'
require './lib/contrato_factory'
require './lib/salario_factory'
require './lib/clasificador_por_hora'
require './lib/clasificador_salario_fijo'
require './repositorios/repositorio_empleado'

$repositorio_empleado = RepositorioEmpleado.new

get "/" do
	@empleados = $repositorio_empleado.obtener_todos
	erb :"index"
end

get "/empleados/nuevo" do
	erb :"nuevo_empleado"
end

post "/empleados/crear_empleado" do
	nuevoEmpleado = Empleado.crear_empleado(params[:empleado_ci], 
								 params[:empleado_nombre], 
								 params[:empleado_apellido], 
								 params[:fecha_de_contrato], 
								 params[:empleado_salario],
								 params[:tipo_de_contrato], 
								 params[:empleado_tipo_salario])
								 
	$repositorio_empleado.adicionar(nuevoEmpleado)
  	@empleados = $repositorio_empleado.obtener_todos
  	erb :"index"
end

get "/empleados/ver/:ci" do
	@empleado = $repositorio_empleado.buscar_por_ci(params[:ci])
	erb :"ver_empleado"
end

post "/empleados/actualizar" do
  @ci_empleado_antiguo = params[:empleado_ci_antiguo] 	
  	if (params[:tipo_de_contrato]=="Mensual") then 
		tipo_contrato_establecido = ContratoMensual.new
	else
		tipo_contrato_establecido = ContratoQuincenal.new
	end

	nuevoEmpleado = Empleado.new(params[:empleado_ci], params[:empleado_nombre], params[:empleado_apellido], params[:fecha_de_contrato], tipo_contrato_establecido, params[:tipo_de_contrato], params[:empleado_tipo_salario], params[:empleado_salario])

	if (params[:empleado_tipo_salario]=="Salario Fijo") then 
		nuevoEmpleado.clasificador_salario = ClasificadorSalarioFijo.new(params[:empleado_salario], params[:fecha_de_contrato])
		nuevoEmpleado.asignar_salario_fijo(params[:empleado_salario])
	else
		nuevoEmpleado.clasificador_salario = ClasificadorPorHora.new(params[:empleado_salario])
		nuevoEmpleado.asignar_pago_por_hora(params[:empleado_salario])
	end

  #@nom = params[:empleado_ci]
  em = nuevoEmpleado.actualizar_empleado(@ci_empleado_antiguo,nuevoEmpleado, em)
  @empleados = em
  erb :"index"
end

get "/empleados/modificar/:ci" do
	@empleado = $repositorio_empleado.buscar_por_ci(params[:ci])
	erb :"modificar_empleado"
end

get "/empleados/eliminar/:ci" do
	@ci = params[:ci]
	@emp = Empleado.new('', '', '', Date.new(2012,1,1), ContratoMensual.new)
	em = @emp.eliminar_empleado_por_ci(@ci,em)
	@empleados = em
	erb :"index"
end


