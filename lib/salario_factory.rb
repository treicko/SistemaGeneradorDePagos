class SalarioFactory
	
  def crear_clasificador_salario(tipo_salario, salario, fecha_inicio_contrato)
  	if (tipo_salario=="Salario Fijo") then 
		ClasificadorSalarioFijo.new(salario, fecha_inicio_contrato)
	else
		ClasificadorPorHora.new(salario)
	end


	if (params[:empleado_tipo_salario]=="Salario Fijo") then 
		nuevoEmpleado.clasificador_salario = ClasificadorSalarioFijo.new(params[:empleado_salario], params[:fecha_de_contrato])
		nuevoEmpleado.asignar_salario_fijo(params[:empleado_salario])
	else
    	nuevoEmpleado.clasificador_salario = ClasificadorPorHora.new(params[:empleado_salario])
    	nuevoEmpleado.asignar_pago_por_hora(params[:empleado_salario])
	end
  end

end