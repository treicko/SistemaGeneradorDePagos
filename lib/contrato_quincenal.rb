class ContratoQuincenal

  def es_dia_pago?(fecha_de_ejecucion)
    fecha_de_ejecucion.strftime("%A") == "Friday"
  end

  def tipo_contrato
  	"Contrato Quincenal"
  end

end