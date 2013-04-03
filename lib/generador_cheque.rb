require ('date')
class GeneradorCheque

  def initialize(fecha_de_ejecucion=Date.today, consola=nil)
    @fecha_de_ejecucion = fecha_de_ejecucion
    @consola = consola
  end

  def ejecutar(empleado)
    beneficiario = empleado.nombre+ " " +empleado.apellido
    monto = empleado.calcular_salario(@fecha_de_ejecucion)

    cheque = Cheque.new(empleado.ci,
                        beneficiario,
                        @fecha_de_ejecucion,
                        monto)
    cheque
  end
end
