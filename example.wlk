
class NaveEspacial{
  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method velocidad() = velocidad
  method direccion() = direccion
  method acelerar(cuanto) {velocidad = (velocidad + cuanto).min(100000)}
  method desacelerar(cuanto) {velocidad = (velocidad - cuanto).max(100000)}
  method irHaciaElSol() {direccion = 10}
  method escaparDelSol() {direccion = -10}
  method ponerseParaleloAlSol() {direccion = 0}
  method acercarseUnPocoAlSol() {direccion = (direccion+1).min(10)}
  method alejarseUnPocoDelSol() {direccion = (direccion-1).max(-10)}

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method cargarCombustible(unaCantidad) {combustible += unaCantidad}
  method combustible() = combustible
  
  method superAcelerar(cuanto) { //Esto es extra
    if(!cuanto.between(0, 50000))
      throw new Exception(message="El valor debe estar entre 0 y 50000")
    else
    self.acelerar(cuanto * 2)
  }
  //throw new Exception(message="Mensaje cualquiera") == self.error("Mensaje cualquiera")
}

class Baliza inherits NaveEspacial {
  var colorDeBaliza

  method colorDeBaliza() = colorDeBaliza
  method cambiarColorDeBaliza(colorNuevo) {colorDeBaliza = colorNuevo}

  override method prepararViaje() {
    super() 
    colorDeBaliza = "verde"
  }
}

class Pasajeros inherits NaveEspacial {
  const property cantPasajeros
  var cantComida
  var cantBebida

  method cargarComida(unaCantidad) {cantComida += unaCantidad}
  method descargarComida(unaCantidad) {cantComida = (cantComida - unaCantidad).max(0)}
  method cargarBebidas(unaCantidad) {cantBebida += unaCantidad}
  method descargarBebidas(unaCantidad) {cantBebida = (cantBebida - unaCantidad).max(0)}

  override method prepararViaje() {
    super()
    self.cargarComida(4 * cantPasajeros)
    self.cargarBebidas(6 * cantPasajeros)
    self.acercarseUnPocoAlSol()
  }
}

class Combate inherits NaveEspacial {
  var estaInvisible = false
  var misilesDesplegados = false
  const property mensajesEmitidos = []

  method ponerseVisible() {estaInvisible = true}
  method ponerseInvisible() {estaInvisible = false}
  method estaInvisible() = !estaInvisible
  method desplegarMisilies() {misilesDesplegados = true}
  method replegarMisiles() {misilesDesplegados = false}
  method misilesDesplegados() = misilesDesplegados
  method emitirMensaje(mensaje) {mensajesEmitidos.add(mensaje)}
  method primerMensajeEmitido() = if(mensajesEmitidos.isEmpty()) self.error("No hay mensajes emitidos") else mensajesEmitidos.first()
  method ultimoMensajeEmitido() = if(mensajesEmitidos.isEmpty()) self.error("No hay mensajes emitidos") else mensajesEmitidos.last()
  method esEscueta() = mensajesEmitidos.all({m=>m.length() <= 30}) //O tambien !mensajesEmitidos.all({m=>m.length() > 30})
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }
}

class Hospital inherits Pasajeros{
  var quirofanosPreparados

  method prepararQuirofanos(){quirofanosPreparados = true}
  method usarQuirofanos(){quirofanosPreparados = false}
  method hayQuirofanoPreparado() = quirofanosPreparados
}
class CombateSigiloso inherits Combate{

}