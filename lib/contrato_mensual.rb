class ContratoMensual

  def es_dia_pago?(fecha_de_ejecucion)
    return (fecha_de_ejecucion.next_day.day==1)
  end

  def tipo_contrato
  	"Contrato Mensual"
  end

end