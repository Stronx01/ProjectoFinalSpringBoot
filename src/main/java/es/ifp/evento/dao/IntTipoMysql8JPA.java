package es.ifp.evento.dao;

import es.ifp.evento.beans.Tipo;

import java.util.List;

public interface IntTipoMysql8JPA {
    List<Tipo>findAll();
    Tipo findById(int idTipo);
}
