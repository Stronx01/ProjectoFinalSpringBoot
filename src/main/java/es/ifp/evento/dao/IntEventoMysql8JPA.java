package es.ifp.evento.dao;

import es.ifp.evento.beans.Evento;

import java.util.List;

public interface IntEventoMysql8JPA {
    List<Evento>findByDestacadoAndEstado(String destacado,String estado);
    List<Evento>findByDestacado(String destacado);
    List<Evento>findByEstado(String estado);
    List<Evento>findByTipo(int idTipo);
    Evento findById(int idEvento);
    int modificarEvento (Evento evento);
}
