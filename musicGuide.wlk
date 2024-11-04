object joaquin{
    var property grupo = "pimpinela"
    const habilidad = 20
    const tarifa = 100

    method habilidad() {
        if(!grupo.isEmpty()){return habilidad + 5}
        else{return habilidad}
    }

    method interpretaBien(cancion) = cancion.duraMas300()

    method tarifa(presentacion){
        if(presentacion.musicos().size() > 1){ return tarifa/2}
        else{return tarifa}
    }
}

object lucia{
    var property grupo = "pimpinela"
    const habilidad = 70
    const tarifa = 500

    method habilidad(){
        if(!grupo.isEmpty()){return habilidad - 20}
        else{return habilidad}
    }

    method interpretaBien(cancion) = cancion.tieneFamiliar()

    method tarifa(presentacion){
        if(presentacion.esConcurrido()){return tarifa}
        else{return tarifa -100}
    }
}

object luisAlberto{
    const tarifa = 1000

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

object cine{
    const duracion = 312
    const letra = "Hoy el viento se abrió quedó vacío el aire una vez más y el manantial 
    brotó y nadie está aquí y puedo ver que solo estallan las hojas al brillar"

    method duraMas300(){return duracion > 300}
    method tieneFamiliar(){return letra.contains("familia")}
}

object laFamilia{
    const duracion = 264
    const letra = "Quiero brindar por mi gente sencilla, por el amor brindo por la familia"

    method duraMas300(){return duracion > 300}
    method tieneFamiliar(){return letra.contains("familia")}
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

