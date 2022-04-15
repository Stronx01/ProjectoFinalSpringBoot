package es.ifp.evento.repository;

import es.ifp.evento.beans.Tipo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoRepsitory extends JpaRepository<Tipo,Integer> {
}
