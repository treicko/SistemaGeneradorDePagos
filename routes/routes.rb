require('date')
require 'sinatra'
require './lib/empleado'
require './lib/contrato_mensual'
require './lib/contrato_quincenal'
require './manager/manager_empleados'


$gestor_empleados = Empleados.new
$empleado_vacio = Empleado.new('', '', '', Date.new(2012,1,1), ContratoMensual.new)

get "/" do
	@empleados = $gestor_empleados.obtener_todos
	erb :"index"
end

get "/empleados/nuevo" do
	#@empleado = Empleado.new('', '', '', Date.new(2012,1,1), ContratoMensual.new, '', '', '')
	erb :"nuevo_empleado"
end

post "/empleados/crear_empleado" do
	nuevoEmpleado = $empleado_vacio.crear_empleado(params[:empleado_ci], 
								 params[:empleado_nombre], 
								 params[:empleado_apellido], 
								 params[:fecha_de_contrato], 
								 params[:empleado_salario],
								 params[:tipo_de_contrato], 
								 params[:empleado_tipo_salario])
								 
	$gestor_empleados.adicionar(nuevoEmpleado)
  	@empleados = $gestor_empleados.obtener_todos
  	erb :"index"
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
	@ci = params[:ci]
	@emp = Empleado.new('', '', '', Date.new(2012,1,1), ContratoMensual.new)
	@empleado = @emp.buscar_empleado_por_ci(@ci,em)
	erb :"modificar_empleado"
end

get "/empleados/eliminar/:ci" do
	@ci = params[:ci]
	@emp = Empleado.new('', '', '', Date.new(2012,1,1), ContratoMensual.new)
	em = @emp.eliminar_empleado_por_ci(@ci,em)
	@empleados = em
	erb :"index"
end

get "/empleados/ver/:ci" do
	@empleado = $gestor_empleados.buscar_por_ci(params[:ci])
	erb :"ver_empleado"
end
