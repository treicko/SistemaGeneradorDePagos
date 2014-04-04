class ContratoFactory
	
  def crear_contrato(tipo_contrato)
  	if (tipo_contrato=="Mensual") then 
		ContratoMensual.new
	else
		ContratoQuincenal.new
	end
  end

end