package es.ifp.evento.dao;

import es.ifp.evento.beans.Usuario;

public interface IntUsuarioMysql8JPA {
    Usuario findById(String username);
    Usuario findByIdPass(String username,String pass);
    int altaUsuario(Usuario usuario);
}
