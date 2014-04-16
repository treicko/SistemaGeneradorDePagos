require('date')
require 'sinatra'
require './lib/empleado'
require './lib/contrato_factory'
require './lib/contrato_mensual'
require './lib/contrato_quincenal'
require './lib/contrato_trimestral'
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
  empleado = Empleado.crear_empleado(params[:empleado_ci], 
								 params[:empleado_nombre], 
								 params[:empleado_apellido], 
								 params[:fecha_de_contrato], 
								 params[:empleado_salario],
								 params[:tipo_de_contrato], 
								 params[:empleado_tipo_salario])
  $repositorio_empleado.actualizar(empleado)
  @empleados = $repositorio_empleado.obtener_todos
  erb :"index"
end

get "/empleados/modificar/:ci" do
	@empleado = $repositorio_empleado.buscar_por_ci(params[:ci])
	erb :"modificar_empleado"
end

get "/empleados/eliminar/:ci" do
	$repositorio_empleado.eliminarPorCI(params[:ci])
	@empleados = $repositorio_empleado.obtener_todos
	erb :"index"
end


