package es.ifp.evento.dao;

import es.ifp.evento.beans.Perfile;

public interface IntPerfileMysql8JPA {
    Perfile findById(int idPerfil);
}
