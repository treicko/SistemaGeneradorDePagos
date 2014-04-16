class ContratoFactory
	
  def crear_contrato(tipo_contrato)
  	if (tipo_contrato=="Mensual") then 
		ContratoMensual.new
	elsif (tipo_contrato=="Quincenal")
		ContratoQuincenal.new
	else
		ContratoTrimestral.new
	end
  end

end