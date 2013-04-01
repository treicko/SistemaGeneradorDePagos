require ('date')

class Cheque

  def initialize(ci, beneficiario, fecha_emision, monto)
    @ci = ci
    @beneficiario = beneficiario
    @monto = monto
    @fecha_emision = fecha_emision
  end

  def obtener_monto()
    @monto
  end

  def obtener_beneficiario()
    @beneficiario
  end

  def obtener_ci()
    @ci
  end

  def obtener_fecha_emision()
    @fecha_emision
  end

  def asignar_monto(monto)
      @monto=monto
  end
end