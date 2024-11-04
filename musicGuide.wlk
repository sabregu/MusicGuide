//Musicos
const kike = new MusicoDeGrupo(habilidad=60,factorDeAumento=20,grupo= null,tarifa= null,albumes=#{})
const soledad = new VocalistaPopular(habilidad=55,palabraAumentaHabilidad="amor",grupo= null,tarifa= null,albumes=#{laSole})
const joaquin = new MusicoDeGrupo(grupo = "pimpinela",habilidad = 20,tarifa = 100,albumes = #{especialFamilia},factorDeAumento=5)
const lucia = new VocalistaPopular(grupo = "pimpinela",habilidad = 70,tarifa= 500,palabraAumentaHabilidad= "familia",albumes= #{})

//Canciones
const cisne = new Cancion(tituloPrincipal="cisne",letra="Hoy el viento se abrió quedó vacío el aire una vez más y el manantial 
    brotó y nadie está aquí y puedo ver que solo estallan las hojas al brillar",duracion= 312)
const laFamilia = new Cancion(tituloPrincipal="la familia",letra="Quiero brindar por mi gente sencilla, por el amor brindo por la familia",duracion=264)
const eres = new Cancion(tituloPrincipal = "eres",duracion = 145, letra="Eres lo mejor que me pasó en la vida, no tengo duda, no habrá más nada después de ti. Eres lo que le dio brillo al día a día, y así será por siempre, no cambiará, hasta el final de mis días.")
const corazon = new Cancion(tituloPrincipal = "corazon americano",duracion= 154,letra="Canta corazón, canta más alto, que tu pena al fin se va marchando, el nuevo milenio ha de encontrarnos, junto corazón, como soñamos")
const alma = new Cancion(tituloPrincipal= "Alma de diamante",duracion = 216,letra ="Ven a mí con tu dulce luz alma de diamante. Y aunque el sol se nuble después sos alma de diamante. cielo o piel silencio o verdad sos alma de diamante. Por eso ven así con la humanidad alma de diamante")
const crisantemo = new Cancion(tituloPrincipal="Crisantemo",duracion = 175,letra = "Tócame junto a esta pared, yo quedé por aquí... cuando no hubo más luz... quiero mirar a través de mi piel... Crisantemo, que se abrió... encuentra el camino hacia el cielo")

//Albumes
const especialFamilia = new Album(canciones = #{laFamilia},tituloAlbum= "Especial La Familia",fechaLanzamiento=920617,unidadesAlaVenta=100000,unidadesVendidas=890000)
const laSole = new Album(canciones = #{eres,corazon},tituloAlbum= "La Sole",fechaLanzamiento= 050205,unidadesAlaVenta=200000,unidadesVendidas=130000)
const paraLosArboles = new Album(canciones=#{cisne,alma},tituloAlbum="para llosa arboles",fechaLanzamiento=030331,unidadesAlaVenta=50000,unidadesVendidas=49000)
const just = new Album(canciones=#{crisantemo},tituloAlbum="just Crisantemo",fechaLanzamiento=071205,unidadesAlaVenta=28000,unidadesVendidas=27500)

object luisAlberto{
    var grupo = null
    var habilidad = 0
    var albumes = #{paraLosArboles,just}
    var tarifa = 1000

    method laPego(){
    return self.albumes().all{album => album.tieneBuenasVentas()}
}
    method duracionObra(){
    return self.albumes().sum{album => album.duracion()}
    }
    method cancionesContienen(palabra){ return
    self.todasSusCanciones().filter{cancion => cancion.letra().contains(palabra)}
    }
    method todasSusCanciones() {return self.albumes().flatMap{album => album.canciones() }}
    method albumes() = albumes
    method esMinimalista(){
    return self.albumes().all{album => album.esMinimalista()}
    }
    method habilidad(guitarra) {if(guitarra.valor() *8 > 100){return 100}
    else{return guitarra.valor() *8}}

    method interpretaBien(cancion){return true}

    method tarifa(presentacion){
        if(presentacion.fecha() < 201101){return tarifa}
        else{return tarifa+200}
    }
    //201101 es 1ro de noviembre de 2020
}

object guitarraFender{
    const valor = 15
    method valor() = valor
}

object guitarraGibson{
    const valor = 15
    var property estado = "sana"

    method valor(){
        if(self.estado() == "sana"){return valor}
        else{return valor/3}
    }
}


object lunaPark{
    const property fecha = 210420
    const property musicos = [luisAlberto,joaquin,lucia]
    const capacidad = 9290

    method costo(){
        return musicos.sum{musico => musico.tarifa(self)}
    }
    method esConcurrido() = capacidad > 5000
}

object laTrastienda{
    const property fecha = 201115
    const property musicos = [luisAlberto,joaquin,lucia]
    const capacidad = 400

    method capacidad(fecha1){
        if(fecha.esSabado()){return capacidad+300}
        else{return capacidad}
    }

    method costo(){
        return musicos.sum{musico => musico.tarifa(self)}
    }

    method esConcurrido() = capacidad > 5000
}

class Musico{
var grupo
var habilidad
var tarifa
var albumes

method todasSusCanciones()  {return self.albumes().flatMap{album => album.canciones() }}
method albumes() = albumes
method grupo(nuevoGrupo){grupo = nuevoGrupo}
method albumes(listaAlbums){albumes = listaAlbums}
method tarifa() = tarifa
method esMinimalista(){
    return self.albumes().all{album => album.esMinimalista()}
    }
method duracionObra(){
    return self.albumes().sum{album => album.duracion()}
}
method laPego(){
    return self.albumes().all{album => album.tieneBuenasVentas()}
}
method cancionesContienen(palabra){return
    self.todasSusCanciones().filter{cancion => cancion.letra().contains(palabra)}
}
}

class MusicoDeGrupo inherits Musico{
var factorDeAumento

    method habilidad() {
        if(!grupo.isEmpty()){return habilidad + factorDeAumento}
        else{return habilidad}
    }
    method interpretaBien(cancion) = cancion.duraMasX()
    method factorDeAumento(nuevoFactor){factorDeAumento=nuevoFactor}
    method tarifa(presentacion){
        if(presentacion.musicos().size() > 1){ return tarifa/2}
        else{return tarifa}
    }
}

class VocalistaPopular inherits Musico{
var palabraAumentaHabilidad

    method habilidad(){
        if(!grupo.isEmpty()){return habilidad - 20}
        else{return habilidad}
    }
    method palabraAumentaHabilidad(nuevaPalabra){palabraAumentaHabilidad = nuevaPalabra}
    method interpretaBien(cancion) = cancion.tienePalabra(palabraAumentaHabilidad)
    method tarifa(presentacion){
        if(presentacion.esConcurrido()){return tarifa}
        else{return tarifa -100}
    }
}

class Cancion{
    const tituloPrincipal
    const letra
    const duracion

    method tituloPrincipal() = tituloPrincipal
    method letra() = letra
    method duracion() = duracion
    method duraMasX(duracionX){return duracion > duracionX}
    method tienePabalabra(palabra){return letra.contains(palabra)}
}

class Album{
    const canciones
    const tituloAlbum
    const fechaLanzamiento
    const unidadesAlaVenta
    const unidadesVendidas

    method canciones()= canciones
    method tituloAlbum()= tituloAlbum
    method fechaLanzamiento()= fechaLanzamiento
    method unidadesAlaVenta()= unidadesAlaVenta
    method unidadesVendidas()= unidadesVendidas
    method duracion() = self.canciones().sum{cancion => cancion.duracion()}
    method esMinimalista() = self.canciones().all{cancion => !cancion.duraMasX(180)}
    method cancionMasLarga() = self.canciones().max{cancion => cancion.letra().size()}.tituloPrincipal()
    method tieneBuenasVentas() = self.unidadesVendidas() > self.unidadesAlaVenta()*0.75
}