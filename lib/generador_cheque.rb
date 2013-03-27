require ('date')
class GeneradorCheque

  def initialize(fecha_de_ejecucion=Date.today, consola=nil)
    @fecha_de_ejecucion = fecha_de_ejecucion
    @consola = consola
  end

  def ejecutar(empleado)
    cheque = Cheque.new
    cheque.asignar_monto(empleado.calcular_salario(@fecha_de_ejecucion))
    cheque.para_empleado(empleado)
    cheque
  end

  def imprimir_cheque(cheque)
    if(@fecha_de_ejecucion.next_day.day!=1)
      @consola.imprimir("No se pudo imprimir el cheque, porque aun no es fin de mes")
    else
      @consola.imprimir("Nombre completo: #{cheque.obtener_nombre_empleado}\nCi: #{cheque.obtener_ci_receptor()}\nMonto a cobrar: #{cheque.obtener_monto()}$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________")
    end
  end

end
