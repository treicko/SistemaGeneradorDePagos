require ('date')
class GeneradorCheque

  def initialize(fecha_de_ejecucion=Date.today, consola=nil)
    @fecha_de_ejecucion = fecha_de_ejecucion
    @consola = consola
  end

  def ejecutar(empleado)
    beneficiario = empleado.obtener_nombre() + " " + empleado.obtener_apellido()
    cheque = Cheque.new(empleado.obtener_ci(), beneficiario, empleado.obtener_salario())
    cheque.asignar_monto(empleado.calcular_salario(@fecha_de_ejecucion))
    cheque
  end

  def imprimir_cheque(cheque)
    if(@fecha_de_ejecucion.next_day.day!=1)
      @consola.imprimir("No se pudo imprimir el cheque, porque aun no es fin de mes")
    else
      @consola.imprimir("Nombre completo: #{cheque.obtener_beneficiario}\nCi: #{cheque.obtener_ci()}\nMonto a cobrar: #{cheque.obtener_monto()}$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________")
    end
  end

end
