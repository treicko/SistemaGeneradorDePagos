require ('date')
class GeneradorCheque

  def initialize(fecha_de_ejecucion=Date.today, consola=nil)
    @fecha_de_ejecucion = fecha_de_ejecucion
    @consola = consola
  end

  def ejecutar(empleado)
    beneficiario = empleado.obtener_nombre()+ " " +empleado.obtener_apellido()
    monto = empleado.calcular_salario(@fecha_de_ejecucion)

    cheque = Cheque.new(empleado.obtener_ci(),
                        beneficiario,
                        @fecha_de_ejecucion,
                        monto)
    cheque
  end
end
