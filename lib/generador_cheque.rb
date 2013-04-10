class GeneradorCheque
  def initialize(fecha_de_ejecucion)
    @fecha_de_ejecucion = fecha_de_ejecucion
  end

  def ejecutar(empleado)
    if(fecha_ejecucion_es_ultimo_dia_mes?)
      beneficiario = empleado.nombre+ " " +empleado.apellido
      monto = empleado.calcular_salario(@fecha_de_ejecucion)

      cheque = Cheque.new(empleado.ci,
                        beneficiario,
                        @fecha_de_ejecucion,
                        monto)
      cheque
    else
      nil
    end
  end

  def fecha_ejecucion_es_ultimo_dia_mes?
    return (@fecha_de_ejecucion.next_day.day==1)
  end

end
