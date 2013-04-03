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

  def imprimir_cheque(cheque)
    if(@fecha_de_ejecucion.next_day.day!=1)
      @consola.imprimir("No se pudo imprimir el cheque, porque aun no es fin de mes")
    else
      @consola.imprimir("Nombre completo: #{cheque.beneficiario}\nCi: #{cheque.ci}\nMonto a cobrar: #{cheque.monto}$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________")
    end
  end

end
