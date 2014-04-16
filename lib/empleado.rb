require('date')

class Empleado
  #attr_accessor :clasificador_salario
  attr_accessor :clasificador_salario
  attr_reader :nombre, :apellido, :ci, :fecha_inicio_contrato, :salario
  

  def initialize(ci, nombre, apellido, fecha_inicio_contrato,clasificador_contrato)
    @ci = ci
    @nombre = nombre
    @apellido = apellido
    @fecha_inicio_contrato = fecha_inicio_contrato
    @descuento_fijo_por_sindicato = 0
    @tarjetas_de_servicio = Array.new
    @descuento_por_servicios = 0
    @clasificador_contrato=clasificador_contrato
  end

  def self.crear_empleado(ci, nombre, apellido, fecha_inicio_contrato, salario, tipo_contrato, tipo_salario)
    contrato = ContratoFactory.new.crear_contrato(tipo_contrato)
    empleado = Empleado.new(ci,nombre, apellido, fecha_inicio_contrato, contrato)
    salario = SalarioFactory.new.crear_clasificador_salario(tipo_salario, salario, fecha_inicio_contrato)
    empleado.clasificador_salario = salario
    return empleado
  end

  def es_dia_pago?(fecha)
    @clasificador_contrato.es_dia_pago?(fecha)
  end
  def asignar_salario_fijo(monto)
     @clasificador_salario.salario = monto
  end

  def asignar_fecha_inicio_contrato(fecha)
    @clasificador_salario.fecha_inicio_contrato = fecha
  end

  def calcular_salario(fecha_ejecucion)
    @clasificador_salario.calcular_salario(fecha_ejecucion) - @descuento_fijo_por_sindicato - calcular_monto_por_servicios_sindicato
  end

  def asignar_descuento_sindicato(monto)
    @descuento_fijo_por_sindicato = monto
  end

  def registrar_tarjeta_de_servicio(tarjeta_de_servicio)
    @tarjetas_de_servicio.push(tarjeta_de_servicio)
  end

  def calcular_monto_por_servicios_sindicato
    @tarjetas_de_servicio.each { |t| @descuento_por_servicios += t.monto}
    @descuento_por_servicios
  end

  def asignar_pago_por_hora(monto)
    @clasificador_salario.monto_por_hora = monto
  end
  
  def registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
    @clasificador_salario.registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
  end

  def buscar_empleado_por_ci(ci_empleado, lista_empleados)
    lista_empleados.each do |empleado|
      if empleado.ci==ci_empleado 
        then @resp = empleado
             return @resp
      end
    end
  end

  def actualizar_empleado(ci_empleado, nuevo_empleado, lista_empleados)
    @nueva_lista_empleados = Array.new
    lista_empleados.each do |empleado|
      if ci_empleado==empleado.ci
        then @nueva_lista_empleados << nuevo_empleado
      else
        @nueva_lista_empleados << empleado
      end
    end
    @nueva_lista_empleados
  end

  def eliminar_empleado_por_ci(ci_empleado, lista_empleados)
    @nueva_lista_empleados = Array.new
    lista_empleados.each do |empleado|
      if ci_empleado!=empleado.ci
        then @nueva_lista_empleados << empleado
      end
    end
    @nueva_lista_empleados
  end

  def contrato_mensual?
    @clasificador_contrato.contrato_mensual?
  end

  def salario_fijo?
    if(@tipo_salario == "Salario Fijo")
      return true
    else
      return false
    end
  end

  def devolver_salario
    @clasificador_salario.devolver_salario
  end

end