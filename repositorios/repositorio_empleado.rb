class RepositorioEmpleado
  def initialize
    @empleados= Array.new
    @empleados.push(Empleado.crear_empleado('3343', 'Juan', 'Perez Asturias', Date.new(2014,2,1), 3000, 'Mensual', 'Salario Fijo'))
    @empleados.push(Empleado.crear_empleado('1234', 'Daniel', 'Mendez Machado', Date.new(2014,2,1), 1300, 'Quincenal', 'Salario Hora'))
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
