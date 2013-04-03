require ('empleado')
require ('generador_cheque')
require ('cheque')
require ('date')
require('consola_test')


describe "Generar cheque para empleado con salario fijo" do

  subject(:empleado) {Empleado.new('3343', 'Juan', 'Perez', Date.new(2012,1,1))}

  it "deberia generar cheque para un empleado" do
    empleado.asignar_salario_fijo(300)
    generador = GeneradorCheque.new(Date.new(2013,1,1))
    cheque = generador.ejecutar(empleado)
    cheque.monto.should == 300
  end

  it "deberia generar cheque para otro empleado(salario 500)" do
    empleado.asignar_salario_fijo(500)
    generador = GeneradorCheque.new(Date.new(2013,1,1))
    cheque = generador.ejecutar(empleado)
    cheque.monto.should == 500
  end

  it "deberia generar cheque con salario completo para un empleado que se contrato el primero del mes" do
    empleado.asignar_salario_fijo(500)
    empleado.asignar_fecha_inicio_contrato(Date.new(2013,4,1))
    generador = GeneradorCheque.new(Date.new(2013,4,30))
    cheque = generador.ejecutar(empleado)
    cheque.monto.to_i.should == 500
  end

  it "deberia generar cheque con mitad de salario para un empleado que se contrato a mitad del mes" do
    empleado.asignar_salario_fijo(500)
    empleado.asignar_fecha_inicio_contrato(Date.new(2013,4,16))
    generador = GeneradorCheque.new(Date.new(2013,4,30))
    cheque = generador.ejecutar(empleado)
    cheque.monto.to_i.should == 250
  end

  it "el cheque generado deberia corresponder al empleado" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.beneficiario.should == "Juan Perez"
  end

  it "el cheque generado para empleado deberia tener su carnet" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.ci.should == "3343"
  end

  it "el cheque generado para empleado deberia tener una fecha de emision al momento de generarse" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.fecha_emision.should == Date.today
  end

  it "el cheque generado para empleado deberia tener una fecha de emision al momento de generarse, y no otra fecha" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.fecha_emision.should_not == Date.today.next_day
  end


  it "no generar (imprimiendo) cheque si no es ultimo dia del mes" do
    consola = ConsolaTest.new
    generador = GeneradorCheque.new(Date.new(2013,12,12), consola)
    cheque = generador.ejecutar(empleado)
    generador.imprimir_cheque(cheque)
    consola.buffer_pantalla.should == "No se pudo imprimir el cheque, porque aun no es fin de mes"
  end

  it "generar (imprimiendo) cheque si es ultimo dia del mes, para un empleado" do
    consola = ConsolaTest.new
    generador = GeneradorCheque.new(Date.new(2013,12,31), consola)
    empleado = Empleado.new('123456', 'pedro', 'mamani',Date.new(2013,11,01))
    empleado.asignar_salario_fijo(2000)
    cheque = generador.ejecutar(empleado)
    generador.imprimir_cheque(cheque)
    consola.buffer_pantalla.should == "Nombre completo: pedro mamani\nCi: 123456\nMonto a cobrar: 2000$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________"
  end

end