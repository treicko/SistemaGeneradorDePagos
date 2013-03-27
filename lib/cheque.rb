require ('date')

class Cheque

  def para_empleado(empleado)
    @empleado = empleado
  end

  def obtener_monto()
    @monto
  end

  def obtener_nombre_empleado()
    if(@empleado.obtener_nombre().nil? || @empleado.obtener_apellido().nil?)
      nil;
    else
      @empleado.obtener_nombre() + " " + @empleado.obtener_apellido()
    end
  end

  def obtener_ci_receptor()
    @empleado.obtener_ci()
  end

  def obtener_fecha_emision()
    Date.today
  end
  def asignar_monto(monto)
      @monto=monto
  end
end