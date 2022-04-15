package es.ifp.evento.repository;

import es.ifp.evento.beans.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UsuarioRepository extends JpaRepository<Usuario,String> {
}
