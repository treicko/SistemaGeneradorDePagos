class RepositorioEmpleado
  def initialize
    @empleados= Array.new
    @empleados.push(Empleado.crear_empleado('111', 'Juan', 'Perez Asturias', Date.new(2014,2,1), 3000, 'Mensual', 'Salario Fijo'))
    @empleados.push(Empleado.crear_empleado('222', 'Daniel', 'Mendez Machado', Date.new(2014,2,1), 50, 'Mensual', 'Salario Hora'))
    @empleados.push(Empleado.crear_empleado('333', 'Pedro', 'Mendizabal Camacho', Date.new(2014,2,1), 2000, 'Quincenal', 'Salario Fijo'))
    @empleados.push(Empleado.crear_empleado('444', 'Sandra', 'Lara Cabrera', Date.new(2014,2,1), 100, 'Quincenal', 'Salario Hora'))
    @empleados.push(Empleado.crear_empleado('555', 'Ariel', 'Lopez Hinojosa', Date.new(2014,2,1), 1000, 'Trimestral', 'Salario Fijo'))
    @empleados.push(Empleado.crear_empleado('666', 'Rodrigo', 'Blanco Pozo', Date.new(2014,2,1), 25, 'Trimestral', 'Salario Hora'))
  end
  
  def obtener_todos
    @empleados
  end
  
  def adicionar(empleado)
    #@empleados.push(empleado)
    #@empleados << empleado
    @empleados.push(empleado)
  end
  
  def buscar_por_ci(ci)
    @empleados.each do |empleado|
      if (empleado.ci==ci)
        return empleado
      end
    end
  end
  
  def actualizar(empleado)
    @empleados = @empleados.map{|emp| if (emp.ci == empleado.ci)
                                        empleado
                                      else
                                        emp
                                      end}
  end
  
end
