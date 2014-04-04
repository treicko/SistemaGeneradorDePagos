class ContratoQuincenal

  def es_dia_pago?(fecha_de_ejecucion)
    fecha_de_ejecucion.strftime("%A") == "Friday"
  end

  def contrato_mensual?
    false
  end

  def obtener_descripcion
  	return "Soy contrato quincenal"
  end

end