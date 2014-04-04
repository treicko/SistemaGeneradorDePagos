class ContratoMensual

  def es_dia_pago?(fecha_de_ejecucion)
    return (fecha_de_ejecucion.next_day.day==1)
  end

  def contrato_mensual?
    true
  end

  def obtener_descripcion
  	"Soy contrato mensual"
  end

end