class Empleados
  def initialize
    @empleados = [Empleado.new('3343', 'Juan', 'Perez', Date.new(2012,2,1),ContratoQuincenal.new), 
  		            Empleado.new('1234', 'Daniel', 'Mendez', Date.new(2012,3,1),ContratoMensual.new)]
  end
  
  def obtener_todos
    @empleados
  end
  
  def adicionar(empleado)
    #@empleados.push(empleado)
    @empleados << empleado
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
