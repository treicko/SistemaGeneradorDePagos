require ('date')

class Cheque

  def initialize(ci, beneficiario, monto)
    @ci = ci
    @beneficiario = beneficiario
    @monto = monto
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
    Date.today
  end

  def asignar_monto(monto)
      @monto=monto
  end
end